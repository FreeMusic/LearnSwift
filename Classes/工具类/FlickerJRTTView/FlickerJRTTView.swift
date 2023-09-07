//
//  FlickerJRTTView.swift
//  LearnSwift
//
//  Created by Apple on 2019/6/19.
//  Copyright © 2019 橘子. All rights reserved.
//

import UIKit

class FlickerJRTTView: UIView {
    
    let textImgView = UIImageView.init()
    let flickerLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textImgView.image = UIImage.init(named: "MengHuanBackGroundText")
        textImgView.contentMode = UIView.ContentMode.scaleAspectFit
        textImgView.frame = self.bounds
        self.addSubview(self.textImgView)
        
        let colors = [
            UIColor.lightGray.cgColor,
            UIColor.gray.cgColor,
            UIColor.gray.cgColor,
            UIColor.lightGray.cgColor,
            ]
        
        flickerLayer.colors = colors
        let locations : [NSNumber] = [
            -0.4,
            -0.39,
            -0.24,
            -0.23,
            ]
        flickerLayer.locations = locations
        
        flickerLayer.startPoint = CGPoint.init(x: 0.0, y: 0.6)
        flickerLayer.endPoint = CGPoint.init(x: 1.0, y: 0.4)
        
        layer.addSublayer(self.flickerLayer)
        
        let layerAnimation  = CABasicAnimation.init(keyPath: "locations")
        layerAnimation.fromValue = [-0.8,-0.79,-0.64,-0.63]
        layerAnimation.toValue = [1.5,1.51,1.76,1.77]
        layerAnimation.duration = 2.0
        layerAnimation.repeatCount = MAXFLOAT
        
        self.flickerLayer.add(layerAnimation, forKey: nil)
        
        self.flickerLayer.frame = self.textImgView.bounds
        self.flickerLayer.mask = self.textImgView.layer
        self.textImgView.frame = self.flickerLayer.bounds
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        

    }
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
