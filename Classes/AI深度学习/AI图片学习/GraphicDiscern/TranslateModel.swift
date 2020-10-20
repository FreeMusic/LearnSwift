//
//  TranslateModel.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/16.
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

"zh-HK",中文(香港)粤语

"sv-SE",

"hu-HU",

"zh-TW",中文(台湾)

"es-ES",

"zh-CN",中文(普通话)

"nl-BE",

"en-GB",英语(英国)

"ar-SA",

"ko-KR",

"cs-CZ",

"en-ZA",

"en-AU",

"da-DK",

"en-US",英语(美国)

"en-IE",

"hi-IN",

"el-GR",

"ja-JP"
 **/
/// 调节语音模型
class VoiceAdjustModel:Codable {
    var pitchMultiplier = 1.00 //音调调节  调节范围 ：[0.5 - 2]  默认是：1
    var volume = 0.5//音量调节  调节范围 ：[0-1]  默认是 ：1
    var rate = 0.5//语速调节  调节范围 ：[0-1]  0最慢  1 最快
    var startPlayVoice = true//默认播放语音
    var playContent = "滴滴滴滴，老司机"
    var language = "zh-CN"//默认中文
    var languageName = "普通话"//语言名称
}


/// 英语翻译汉语模型
class TranslateModel: Codable {
    var from: String
    var to: String
    var trans_result:[ContentModel]
    
}

class ContentModel: Codable {
    var src: String
    var dst: String
}
