//
//  VoicePlayTool.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/20.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit
import AVFoundation

class VoicePlayTool: NSObject, AVSpeechSynthesizerDelegate {
    static let mannger = VoicePlayTool()//单例
    
    let voice = AVSpeechSynthesizer.init()
    
    //开始讲话
    func startPlayVoice(model: VoiceAdjustModel) {
        if model.startPlayVoice == false {
            return
        }
        self.voice.delegate = self
        let speech = AVSpeechUtterance.init(string: model.playContent)
        speech.pitchMultiplier = Float(model.pitchMultiplier)
        speech.rate = Float(model.rate)
        speech.volume = Float(model.volume)
        let languageVoice = AVSpeechSynthesisVoice.init(language: model.language)
        speech.voice = languageVoice
        self.voice.speak(speech)
    }
    
    //暂停讲话 或者 继续讲话
    func pauseOrContinueSpeak(isPause:Bool) {
        if isPause {
            self.voice.stopSpeaking(at: AVSpeechBoundary.word)
        }else{
            self.voice.continueSpeaking()
        }
    }
}
