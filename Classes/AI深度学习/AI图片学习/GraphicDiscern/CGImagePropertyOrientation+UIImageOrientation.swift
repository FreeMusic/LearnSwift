//
//  CGImagePropertyOrientation+UIImageOrientation.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/15.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit
import ImageIO

extension CGImagePropertyOrientation {
    
    init(_ orientation:UIImageOrientation) {
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
    
}
