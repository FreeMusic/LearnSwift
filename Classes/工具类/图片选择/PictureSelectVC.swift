//
//  PictureSelectVC.swift
//  LearnSwift
//
//  Created by 橘子 on 2019/3/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class PictureSelectVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.initButton(title: "选择图片", radius: 10, color: .mainBackColor, addView: self.view) { (sender) in
            let albumList = AlbumListViewController()
            let nav = UINavigationController(rootViewController: albumList)
            self.present(nav, animated: true)
            
            albumList.commpleted = {[weak self] images in
                
                RYQLog(images!)
            }
        }
        button.frame = CGRect.init(x: 100, y: NavigationBarHeight*3, width: 100, height: 50)
        
    }
    
}
