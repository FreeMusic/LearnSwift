//
//  FlickerJRTTVC.swift
//  LearnSwift
//
//  Created by Apple on 2019/6/19.
//  Copyright © 2019 橘子. All rights reserved.
//

import UIKit

class FlickerJRTTVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let height = 200*m6Scale
        
        let flickerView = FlickerJRTTView.init(frame: CGRect.init(x: 0, y: (kScreenHeight-height)/2, width: kScreenWidth, height: height))
        self.view.addSubview(flickerView)
    }
    

}
