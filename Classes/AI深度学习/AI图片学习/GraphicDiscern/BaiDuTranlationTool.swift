//
//  BaiDuTranlationTool.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/19.
//  Copyright © 2020 橘子. All rights reserved.
//  百度英译汉翻译工具

import UIKit
import CommonCrypto

class BaiDuTranlationTool: NSObject {
    
    static let mannger = BaiDuTranlationTool()//单例
    
    //请求完成后的闭包回调
    typealias ComplitionHandler = (String) -> Void
    var translationHandler:ComplitionHandler!
    
    
    /// 百度翻译
    func translateToChinese(transString:String, _ handler:@escaping ComplitionHandler) {
        self.translationHandler = handler
        let baiDuApi = "https://fanyi-api.baidu.com/api/trans/vip/translate"
        let appID = "20201016000591016"
        let md5Str = "dJliZ8Rr_h4zXhTs3SeS"
        let salt = "1435660288"
        
        let appendStr = appID + transString + salt + md5Str
        let MD5String = appendStr.DDMD5Encrypt()
        
        let requestUrl = baiDuApi + "?" + "q=" + transString + "&from=en&to=zh&appid=" + appID + "&salt=" + salt + "&sign=" + MD5String
        let url = requestUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        
        SXYNetWork.work.GetRequest(url: url!, paramters: nil) { (data) in
            let decoder = JSONDecoder()
            let product = try? decoder.decode(TranslateModel.self, from: (data.json?.data(using: .utf8))!)
            /// 获取的翻译结果处理
            self.translateResultHandler(product: product!)
        }
    }
    
    
    /// 获取的翻译结果处理
    func translateResultHandler(product:TranslateModel) {
        var result = ""
        for model in product.trans_result {
            let rateString = model.dst.prefix(4)
            RYQLog(rateString)
            var num:Double? = Double(rateString)
            num = num ?? 0
            if num == 0.00 {
                break;
            }
            let resultString = model.dst.replacingOccurrences(of: rateString, with: String.init(format: "%.2f%@的可能性为", num!*100, "%"))
            result = result + "\n" + resultString
        }
        self.translationHandler(result)
    }
    
    
    /// 去除字符串中重复的部分
    func removeResultDuplicationPart(result:String){
        RYQLog("原本字符串===============\(result)")
        var strResult:String = ""
        //字符串转数组
        var array = result.map { String($0) }
        
        for i in 0..<array.count {
            
            var j = i + 1
            
            while j < array.count{
                let str1 = array[i]
                let str2 = array[j]
                if str1 == str2 {
                    array.remove(at: j)
                    j = j-1
                }else{
                    break
                }
                j = j + 1
            }
            
        }
        
        //数组转字符串
        strResult = array.joined()
        
        RYQLog("删除后得到字符串===============\(strResult)")
    }
}

extension String {
    
    /// MD5加密类型
    enum MD5EncryptType {
        /// 32位小写
        case lowercase32
        /// 32位大写
        case uppercase32
        /// 16位小写
        case lowercase16
        /// 16位大写
        case uppercase16
    }
    
    /// MD5加密 默认是32位小写加密
    /// - Parameter type: 加密类型
    /// - Returns: 加密字符串
    func DDMD5Encrypt(_ md5Type: MD5EncryptType = .lowercase32) -> String {
        guard self.count > 0 else {
            print("⚠️⚠️⚠️md5加密无效的字符串⚠️⚠️⚠️")
            return ""
        }
        /// 1.把待加密的字符串转成char类型数据 因为MD5加密是C语言加密
        let cCharArray = self.cString(using: .utf8)
        /// 2.创建一个字符串数组接受MD5的值
        var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        /// 3.计算MD5的值
        /*
         第一个参数:要加密的字符串
         第二个参数: 获取要加密字符串的长度
         第三个参数: 接收结果的数组
         */
        CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
        
        switch md5Type {
        /// 32位小写
        case .lowercase32:
            return uint8Array.reduce("") { $0 + String(format: "%02x", $1)}
        /// 32位大写
        case .uppercase32:
            return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
        /// 16位小写
        case .lowercase16:
            return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
            //            let tempStr = uint8Array.reduce("") { $0 + String(format: "%02x", $1)}
            //            return tempStr.getString(startIndex: 8, endIndex: 24)
        /// 16位大写
        case .uppercase16:
            return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
            //            let tempStr = uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
            //            return tempStr.getString(startIndex: 8, endIndex: 24)
        }
        
    }
}
