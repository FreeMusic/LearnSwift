//
//  UIView+Extention.swift
//  StarAPP
//
//  Created by 橘子 on 2018/11/29.
//  Copyright © 2018年 橘子Star. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /**
     为一个View添加两种渐变色
     */
    func twoKindsOfGradient(firstColor:UIColor, secondColor:UIColor) {
        
        let gradientColors = [secondColor.cgColor, firstColor.cgColor]
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.4, 1]
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    /**
     寻找View所在的控制器
     */
    func ViewController() -> UIViewController {
        
        var next = self.next
        while true {
            
            if (next?.next?.isKind(of: UIViewController.self))! {
                return next?.next as! UIViewController
            }
            
            next = next?.next
        }
        
    }
    
    /**
     View的旋转 传的参数是PI 旋转角度
     */
    func rotateView(pi:Double) {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform.init(rotationAngle: CGFloat(pi))
        }) { (finish) in
            
        }
    }
}
