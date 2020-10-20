//
//  UIColor+Extention.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/20.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit

extension UIColor {
     class func randomRGB() -> UIColor {

        return UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)

    }
}
