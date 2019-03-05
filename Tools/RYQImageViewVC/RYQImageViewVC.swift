//
//  RYQImageViewVC.swift
//  StarAPP
//
//  Created by 橘子 on 2019/1/21.
//  Copyright © 2019年 橘子Star. All rights reserved.
//

import UIKit

class RYQImageViewVC: MyCollectionViewVC {
    
    var imageURLs = [String]()//网络图片 数组
//    var images = [String]()//本地图片数组
    //默认显示的图片索引
    var index:Int = 0
    //页控制器（小圆点）
    var pageControl : UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.view.backgroundColor = black
        self.collectionView.register(RYQPhotoColletionCell.self, forCellWithReuseIdentifier: "RYQPhotoColletionCell")
        self.collectionView.isPagingEnabled = true
        self.collectionView.isScrollEnabled = true
        //将视图滚动到默认图片上
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        //设置页控制器
        pageControl = UIPageControl()
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                     y: UIScreen.main.bounds.height - 20)
        pageControl.numberOfPages = self.imageURLs.count
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = index
        view.addSubview(self.pageControl)
    }
    
    //初始化
    init(images:[String], index:Int = 0){
        self.imageURLs = images
        self.index = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RYQPhotoColletionCell", for: indexPath) as! RYQPhotoColletionCell
        cell.loadImageURL(url: self.imageURLs[indexPath.row])
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageURLs.count
    }
    
    /**
     设置item的大小
     */
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth, height: kScreenHeight)
    }
    
    //collectionView里某个cell将要显示
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? RYQPhotoColletionCell{
            //由于单元格是复用的，所以要重置内部元素尺寸
            cell.resetSize()
        }
    }
    
    //collectionView里某个cell显示完毕
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        //当前显示的单元格
        let visibleCell = collectionView.visibleCells[0]
        //设置页控制器当前页
        self.pageControl.currentPage = collectionView.indexPath(for: visibleCell)!.item
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension RYQImageViewVC {
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


