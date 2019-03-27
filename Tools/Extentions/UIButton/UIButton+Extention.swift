//
//  UIButton+Extention.swift
//  LearnSwift
//
//  Created by 橘子 on 2019/3/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

import Foundation
import UIKit

/// RYQButtonBackColor 按钮背景色
///
/// - mainColor: 主色调
/// - mainColor: 灰色 不与用户交互
/// - grayWhiteTitleColor: 灰色背景 黑色
/// - mainBackColor: 主色调背景 边框
/// - grayBackColor: 灰色背景 边框
/// - grayBackColor: title主色调 背景主色调alpha
enum RYQButtonBackColor {
    case mainColor
    case grayColor
    case grayTitleColor
    case clearColor
    case mainBackColor
    case grayBackColor
    case mainTitleColor
    case whiteBacklineColor
}

private var colorKey: Void?//颜色
private var actionKey: Void?//点击事件
/**
 按钮的点击事件闭包
 */
typealias buttonAction = (UIButton) -> Void

extension UIButton {
    /**
     runtime 为button添加color属性
     */
    var color:RYQButtonBackColor{
        
        get {
            return (objc_getAssociatedObject(self, &colorKey) as? RYQButtonBackColor)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &colorKey, newValue, objc_AssociationPolicy(rawValue: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN.rawValue)!)
            //color属性的赋值判断
            self.setColor(color: newValue)
        }
    }
    /**
     color属性的赋值判断
     */
    func setColor(color:RYQButtonBackColor) {
        self.isUserInteractionEnabled = true
        switch color {
        case .mainColor:
            self.backgroundColor = ButtonBackColor
            self.setTitleColor(white, for: UIControlState.normal)
        case.grayColor:
            self.backgroundColor = UIColor.FromRGB(hexadecimal: "#e8eaed")
            self.setTitleColor(white, for: UIControlState.normal)
            self.isUserInteractionEnabled = false
            
        case.grayTitleColor:
            self.backgroundColor = UIColor.FromRGB(hexadecimal: "#e8eaed")
            self.setTitleColor(UIColor.FromRGB(hexadecimal: "#777e90"), for: UIControlState.normal)
        case.clearColor:
            self.backgroundColor = clear
            self.setTitleColor(ButtonBackColor, for: UIControlState.normal)
            
        case.grayBackColor:
            self.backgroundColor = UIColor.FromRGB(hexadecimal: "#8d94a2").withAlphaComponent(0.2)
            self.setTitleColor(UIColor.FromRGB(hexadecimal: "#8d94a2").withAlphaComponent(0.8), for: UIControlState.normal)
            self.layer.borderWidth = 0
            break
            
        case.mainBackColor:
            self.setTitleColor(ButtonBackColor, for: UIControlState.normal)
            self.layer.borderColor = ButtonBackColor.cgColor
            self.layer.borderWidth = 1
            self.backgroundColor = ButtonBackColor.withAlphaComponent(0.3)
            break
        case.mainTitleColor :
            self.setTitleColor(ButtonBackColor, for: UIControlState.normal)
            self.backgroundColor = ButtonBackColor.withAlphaComponent(0.3)
            break
        case.whiteBacklineColor :
            self.setTitleColor(ButtonBackColor, for: UIControlState.normal)
            self.layer.borderColor = ButtonBackColor.cgColor
            self.layer.borderWidth = 1
            self.backgroundColor = white
            break
        default: break
            
        }
    }
    /**
     文字按钮的创建
     */
    class func initButton(title:String, radius:CGFloat,color:RYQButtonBackColor, addView:UIView, action:@escaping buttonAction) -> UIButton {
        let button = UIButton()
        button.color = color
        button.setTitle(title, for: UIControlState.normal)
        button.layer.cornerRadius = radius*m6Scale
        button.layer.masksToBounds = true
        button.adjustsImageWhenHighlighted = false
        addView.addSubview(button)
        
//        objc_setAssociatedObject(button, &actionKey, action, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        objc_setAssociatedObject(button as Any, &actionKey, action as? Any, .OBJC_ASSOCIATION_COPY)
        button.addTarget(button, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        
        return button
    }
    /**
     图片按钮的创建
     */
    class func initImageButton(imageName:String, addView:UIView, action:@escaping buttonAction) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        button.adjustsImageWhenHighlighted = false
        addView.addSubview(button)
        
        objc_setAssociatedObject(button as Any, &actionKey, action as? Any, .OBJC_ASSOCIATION_COPY)
        button.addTarget(button, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        
        return button
    }
    
    /**
     左图片右文字的按钮
     */
    class func initTextAndImageButton(imageName:String, title:String, font:UIFont, action:@escaping buttonAction) -> UIButton{
        
        let button = UIButton.init()
        button.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(white, for: UIControlState.normal)
        button.titleLabel?.font = font
        
        objc_setAssociatedObject(button as Any, &actionKey, action as? Any, .OBJC_ASSOCIATION_COPY)
        button.addTarget(button, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        
        return button
    }
    /**
     文字按钮 无背景颜色
     */
    class func buttonWithText(title:String, color:UIColor, font:UIFont, action:@escaping buttonAction) -> UIButton {
        let button = UIButton.init()
        
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(color, for: UIControlState.normal)
        button.titleLabel?.font = font
        
        objc_setAssociatedObject(button as Any, &actionKey, action as? Any, .OBJC_ASSOCIATION_COPY)
        button.addTarget(button, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        
        return button
    }
    
    /**
     按钮的点击事件
     */
    @objc func buttonClick(sender:UIButton) -> Void {
        let action:buttonAction = objc_getAssociatedObject(sender, &actionKey) as! buttonAction
        action(sender)
    }
    
}
