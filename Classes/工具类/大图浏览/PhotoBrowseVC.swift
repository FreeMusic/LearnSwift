//
//  PhotoBrowseVC.swift
//  LearnSwift
//
//  Created by 橘子 on 2019/3/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class PhotoBrowseVC: BaseViewController {
    
    let images = [
        "http://image.zhongleme.net/zlmclientimg_155168809185950659",
        "http://image.zhongleme.net/zlmclientimg_155168809186177281",
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton.initButton(title: "浏览大图", radius: 10, color: .mainBackColor, addView: self.view) { (sender) in
            let imageVC = RYQImageViewVC.init(images: self.images , index: 0)
            self.navigationController?.pushViewController(imageVC, animated: true)
        }

        button.frame = CGRect.init(x: 100, y: NavigationBarHeight*3, width: 100, height: 50)
    }


}
