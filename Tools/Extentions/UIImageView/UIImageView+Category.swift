//
//  UIImageView+Category.swift
//  StarAPP
//
//  Created by 橘子 on 2018/11/16.
//  Copyright © 2018年 橘子Star. All rights reserved.
//

import Foundation
import Kingfisher
import SnapKit
/**
 UIImageView的创建和图片加载
 */
extension UIImageView {
    
    /**
     基于Kingfisher加载网络图片
     */
    func setImage(imageName:String) {
        if imageName.isEmpty {
            return;
        }
        self.kf.setImage(with: ImageResource(downloadURL: URL.init(string: imageName)!))
    }
    
    /**
     基于Kingfisher加载网络图片
     带有占位图
     */
    func setImageWithHolder(imageName:String, holder:String){
        if imageName.isEmpty {
            return;
        }
//        self.kf.setImage(with: ImageResource(downloadURL: URL.init(string: imageName)!), placeholder: UIImage.init(named: holder), options: nil, progressBlock: nil, completionHandler: nil)
        self.kf.setImage(with: ImageResource(downloadURL: URL.init(string: imageName)!), placeholder: UIImage.init(named: holder), options: nil, progressBlock: nil) { (image, error, type, url) in
            RYQLog(error)
        }
    }
    /**
     图片的加载imageName
     */
    class func initImageView (imageName:String, subView:UIView) -> UIImageView {
        let imageView = UIImageView.init(image: UIImage.init(named: imageName))
        subView.addSubview(imageView)
        return imageView
    }
    
}
/**
 图片的旋转和动画
 */
extension UIImageView {
    /**
     view动画旋转180度
     */
    func rotateViewPI_2() {
        UIView.animate(withDuration: 0.2) {
            //翻转图片的方向
            let flipImageOrientation = ((self.image?.imageOrientation.rawValue)! + 4) % 8
            //翻转图片
            let flipImage = UIImage(cgImage: (self.image?.cgImage!)!, scale: (self.image?.scale)!, orientation: UIImageOrientation(rawValue: flipImageOrientation)!)
            
            //图片显示
            self.image = flipImage
        }
    }
    // 360度旋转图片
    func rotate360Degree() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = NSNumber(value: Double.pi/2) // 旋转角度
        rotationAnimation.duration = 0.6 // 旋转周期
        rotationAnimation.isCumulative = true // 旋转累加角度
        rotationAnimation.repeatCount = 45 // 旋转次数
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    func rotate360DegreeWithImageView()
    {
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D:CATransform3DIdentity)
        
        //围绕Z轴旋转，垂直与屏幕
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(3.14, 0.0, 0.0, 1.0))
        animation.duration = 0.5
        //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
        animation.isCumulative = true
        animation.repeatCount = 1000
        
        self.layer.anchorPoint = CGPoint.init(x: 0, y: 0)
        self.layer.transform = CATransform3DMakeRotation( 0.97 , 1.0, 0.0, 0.0)
        self.layer.add(animation, forKey:nil)
    }
}

