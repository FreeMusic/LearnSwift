//
//  LanguageSelectVC.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/20.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit
/** 语种
"th-TH",

"pt-BR",

"sk-SK",

"fr-CA",

"ro-RO",

"no-NO",

"fi-FI",

"pl-PL",

"de-DE",

"nl-NL",

"id-ID",

"tr-TR",

"it-IT",

"pt-PT",

"fr-FR",

"ru-RU",

"es-MX",

"sv-SE",

"hu-HU",

"es-ES",

"nl-BE",

"ar-SA",

"ko-KR",

"cs-CZ",

"en-ZA",

"en-AU",

"da-DK",
"en-IE",

"hi-IN",

"el-GR",

 **/
class LanguageSelectVC: XYCollectionViewVC {
    
    let languages = [
        "zh-CN",
        "zh-HK",
        "zh-TW",
        "en-GB",
        "en-US",
        "ja-JP",
        "ko-KR",
    ]
    
    let languageAllKeys = [
        "普通话",
        "粤语",
        "台湾话",
        "英语(英国)",
        "英语(美国)",
        "日语",
        "韩语",
    ]
    
    //请求完成后的闭包回调
    typealias ComplitionHandler = (String, String) -> Void
    var handler:ComplitionHandler!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择语言"
        self.collectionView.register(LanguageCell.self, forCellWithReuseIdentifier: "LanguageCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.languageAllKeys.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        
        cell.titleLabel.text = self.languageAllKeys[indexPath.row]
        
        return cell
    }
    
    /**
     设置item的大小
     */
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth/4 , height: 50)
    }
    
    /**
     设置item之间Y的间距
     */
     override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    /**
     设置item之间X的间距
     */
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let languageName = self.languageAllKeys[indexPath.row]
        let language = self.languages[indexPath.row]
        
        if (self.handler != nil) {
            self.handler(languageName, language)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}

class LanguageCell: UICollectionViewCell {
    
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel = UILabel.init()
        self.titleLabel.textColor = white
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.backgroundColor = ButtonBackColor
        self.titleLabel.layer.cornerRadius = 25
        self.titleLabel.layer.masksToBounds = true
        self.titleLabel.textAlignment = NSTextAlignment.center
        
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
