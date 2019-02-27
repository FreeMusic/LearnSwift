//
//  BaseViewController.swift
//  排序算法Demo
//
//  Created by 橘子 on 2019/1/24.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var array = [3, 6, 2, 7, 4, 45, 22, 67, 43, 100, 56, 78, 453]//无序
    var times = 0
    /**
     *  title 跳转的控制器的标题
     *  `class` 跳转的控制器
     */
    struct ArithmeticMessage {
        let title:String
        let `class` : AnyClass
    }
    
    var ArithmeticMessages = [
        ArithmeticMessage.init(title: "冒泡排序", class: BubbleSortVC.self),
        ArithmeticMessage.init(title: "快速排序", class: QuickSortVC.self),
        ArithmeticMessage.init(title: "插入排序", class: InsertionSortVC.self),
        ArithmeticMessage.init(title: "希尔排序", class: HillSortVC.self),
        ArithmeticMessage.init(title: "选择排序", class: SelectionSortVC.self),
        ArithmeticMessage.init(title: "归并排序", class: MergeSortVC.self),
        ArithmeticMessage.init(title: "堆排序", class: HeapSortVC.self),
        ArithmeticMessage.init(title: "SwiftGCD", class: GCDVC.self),
        ArithmeticMessage.init(title: "数据结构之数组", class: ArrayVC.self),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }

}
