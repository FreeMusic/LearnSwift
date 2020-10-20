//
//  VoiceSetTool.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/20.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit

class VoiceSetTool: UIView {
    
    var voicePlayButton:UIButton!
//    var pitchSlider:UISlider!
//    var volumeSlider:UISlider!
//    var rateSlider:UISlider!
    var voiceModel: VoiceAdjustModel!
    var numArray:[Double]!
    var languageButton:UIButton!//语言选择
    
    
    let ToolBasicTag = 3457//基础tag
    let rankArray = [2,4,6]
    let array = ["音调调节：", "音量调节：", "语速调节："]
    let maxSliderValues = [2, 1, 1]
    let minSliderValues = [0.5, 0, 0]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.randomRGB()
        /// 添加曲线完成按钮
        self.addCancleFinishButton()
    }
    
    func setVoiceModel(model:VoiceAdjustModel) {
        self.voiceModel = model
        numArray = [model.pitchMultiplier, model.volume, model.rate] as [Double]
        self.languageButton.setTitle("当前语言："+model.languageName, for: UIControlState.normal)
        for index in self.rankArray {
            let label = self.viewWithTag(ToolBasicTag+index) as! UILabel
            label.text = array[(index/2)-1] + String(numArray[(index/2)-1])
            
            let slider = self.viewWithTag(ToolBasicTag*2+index) as! UISlider
            slider.value = Float(numArray[(index/2)-1])
        }
    }
    
    /// 添加曲线完成按钮
    func addCancleFinishButton()  {
        
//        //取消
//        let cancelButton = self.getButton(title: "取消", tag: 1000)
//        cancelButton.snp.makeConstraints { (make) in
//            make.left.equalTo(20)
//            make.top.equalTo(10)
//            make.size.equalTo(CGSize.init(width: 60, height: 30))
//        }
        
        //确定
        let makeSureButton = self.getButton(title: "完成", tag: 1001)
        makeSureButton.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(10)
            make.size.equalTo(CGSize.init(width: 60, height: 30))
        }
        
        //语音播放
        voicePlayButton = UIButton.initButton(title: "语音播放开启", radius: 20, color: RYQButtonBackColor.mainColor, addView: self, action: { (button) in
            self.voiceModel.startPlayVoice = button.isSelected
            button.isSelected = !button.isSelected
        })
        voicePlayButton.setTitle("语音播放关闭", for: UIControlState.selected)
        voicePlayButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        voicePlayButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(makeSureButton.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: 100, height: 40))
        }
        
        //语言选择
        languageButton = UIButton.initButton(title: "当前语言为：", radius: 20, color: RYQButtonBackColor.mainColor, addView: self, action: { (button) in
            //跳转至语言选择界面
            let languageVC = LanguageSelectVC.init()
            
            self.ViewController().navigationController?.pushViewController(languageVC, animated: true)
        })
        languageButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        languageButton.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(makeSureButton.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: 150, height: 40))
        }
        
        for index in self.rankArray {
            self.addTextLabelAndSlider(rankIndex: index)
        }
        
        
    }
    
    func addTextLabelAndSlider(rankIndex:Int) {
        
        //提示
        let pitchLabel = UILabel.init()
        pitchLabel.text = array[(rankIndex/2)-1]
        pitchLabel.font = UIFont.systemFont(ofSize: 14)
        pitchLabel.tag = ToolBasicTag+rankIndex
        self.addSubview(pitchLabel)
        pitchLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(self.voicePlayButton.snp.bottom).offset(20+80*((rankIndex/2)-1))
        }
        
        //音调调节
        let pitchSlider = UISlider.init()
        pitchSlider.maximumValue = Float(maxSliderValues[rankIndex/2-1])
        pitchSlider.minimumValue = Float(minSliderValues[rankIndex/2-1])
        pitchSlider.tag = ToolBasicTag*2+rankIndex
        self.addSubview(pitchSlider)
        pitchSlider.addTarget(self, action: #selector(sliderValueChanged(slider:)), for: UIControlEvents.valueChanged)
        pitchSlider.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(pitchLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
    
    //滑动条改变
    @objc func sliderValueChanged(slider:UISlider) {
        let labelTag = slider.tag - ToolBasicTag
        let index = labelTag - ToolBasicTag
        
        let label = self.viewWithTag(labelTag) as! UILabel
        label.text = array[(index/2)-1] + String(slider.value)
        if index == rankArray[0] {
            self.voiceModel.pitchMultiplier = Double(slider.value)
        }else if(index == rankArray[1]) {
            self.voiceModel.volume = Double(slider.value)
        }else if(index == rankArray[2]) {
            self.voiceModel.rate = Double(slider.value)
        }
    }
    
    //获取按钮
    func getButton(title:String, tag:Int) -> UIButton {
        let newButton = UIButton.initButton(title: title, radius: 15, color: RYQButtonBackColor.mainColor, addView: self) { (button) in
            UIView.animate(withDuration: 0.3) {
                self.frame = CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: 500)
            }
        }
        newButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        newButton.tag = tag
        
        return newButton
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
