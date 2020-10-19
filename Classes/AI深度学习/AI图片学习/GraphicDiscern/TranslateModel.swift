//
//  TranslateModel.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/16.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit

class TranslateModel: Codable {
    var from: String
    var to: String
    var trans_result:[ContentModel]
    
}

class ContentModel: Codable {
    var src: String
    var dst: String
}
