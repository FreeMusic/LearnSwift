//
//  LanguageSelectVC.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/20.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit

class LanguageSelectVC: XYCollectionViewVC {
    
    let languages = ["zh-CN", "zh-HK",]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择语言"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        
        
        return cell
    }
    
    /**
     设置item的大小
     */
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth/4 , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

class LanguageCell: UICollectionViewCell {
    
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel = UILabel.init()
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
