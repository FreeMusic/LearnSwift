//
//  TranslateModel.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/16.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit


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
