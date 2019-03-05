//
//  RYQPhotoColletionCell.swift
//  StarAPP
//
//  Created by 橘子 on 2019/1/21.
//  Copyright © 2019年 橘子Star. All rights reserved.
//

import UIKit
import Kingfisher

class RYQPhotoColletionCell: UICollectionViewCell, UIScrollViewDelegate {
    //用于显示图片的imageView
    var imageView = UIImageView.init(image: UIImage.init(named: "BedDetailsPlaceHolder"))
    //大图浏览时候的滑动视图
    var scrollView:UIScrollView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        //滑动视图初始化
        self.initScrollView()
        //imageView的初始化
        self.initImageView()
        //添加监听
        self.addToMonitor()
    }
    /**
     滑动视图初始化
     */
    func initScrollView() {
        self.scrollView = UIScrollView(frame: self.bounds)
        self.addSubview(self.scrollView)
        scrollView.delegate = self
        //设置scrollView的缩放范围
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
    }
    /**
     imageView的初始化
     */
    func initImageView() {
        imageView.frame = scrollView.bounds
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
    }
    
    //视图布局改变时（横竖屏切换时cell尺寸也会变化）
    override func layoutSubviews() {
        super.layoutSubviews()
        //重置单元格内元素尺寸
        resetSize()
    }
    //重置单元格内元素尺寸
    func resetSize(){
        //scrollView重置，不缩放
        scrollView.frame = self.contentView.bounds
        scrollView.zoomScale = 1.0
        //imageView重置
        if let image = self.imageView.image {
            //设置imageView的尺寸确保一屏能显示的下
            imageView.frame.size = scaleSize(size: image.size)
            //imageView居中
            imageView.center = scrollView.center
        }
    }
    //获取imageView的缩放尺寸（确保首次显示是可以完整显示整张图片）
    func scaleSize(size:CGSize) -> CGSize {
        let width = size.width
        let height = size.height
        let widthRatio = width/UIScreen.main.bounds.width
        let heightRatio = height/UIScreen.main.bounds.height
        let ratio = max(heightRatio, widthRatio)
        return CGSize(width: width/ratio, height: height/ratio)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadImageURL(url:String) {
        self.imageView.kf.setImage(with: ImageResource(downloadURL: URL.init(string: url)!), placeholder: UIImage.init(named: "BedDetailsPlaceHolder"), options: nil, progressBlock: nil) { (image, error, type, url) in
            
        }
    }
}

extension RYQPhotoColletionCell {
    /**
     添加监听
     */
    func addToMonitor() {
        //手指单击监听
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapSingleDid))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.imageView.addGestureRecognizer(tap)
        //手指双击监听
        let tapTwice = UITapGestureRecognizer.init(target: self, action: #selector(tapTwicePictureEnlarge))
        tapTwice.numberOfTouchesRequired = 1
        tapTwice.numberOfTapsRequired = 2
        self.imageView.addGestureRecognizer(tapTwice)
        //声明点击事件需要双击事件检测失败后才会执行
        tap.require(toFail: tapTwice)
    }
    /**
     图片单击事件响应
     */
    @objc func tapSingleDid(_ ges:UITapGestureRecognizer){
//        if self.scrollView.zoomScale > 1 {
//            self.scrollView.zoomScale = 1
//        }else{
            let imgVC = self.ViewController() as! RYQImageViewVC
            imgVC.navigationController?.popViewController(animated: true)
//        }
    }
    /**
     图片双击放大
     */
    @objc func tapTwicePictureEnlarge(_ ges:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            //如果当前不缩放，则放大到3倍。否则就还原
            if self.scrollView.zoomScale == 1.0 {
                self.scrollView.zoomScale = 3.0
            }else{
                self.scrollView.zoomScale = 1.0
            }
        }
    }
}

//ImagePreviewCell的UIScrollViewDelegate代理实现
extension RYQPhotoColletionCell {
    
    //缩放视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    //缩放响应，设置imageView的中心位置
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var centerX = scrollView.center.x
        var centerY = scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ?
            scrollView.contentSize.width/2:centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ?
            scrollView.contentSize.height/2:centerY
        imageView.center = CGPoint(x: centerX, y: centerY)
    }
}

