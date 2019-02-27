//
//  BubbleSortVC.swift
//  排序算法Demo
//
//  Created by 橘子 on 2019/1/24.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit
/**
 冒泡排序 相邻元素进行比较，按照升序或者降序，交换两个相邻元素的位置 是一种“稳定排序算法”
 */
class BubbleSortVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bubbleSortWithArray(list: array)
    }
    /**
     冒泡排序  时间复杂度----O(n^2)
     */
    func bubbleSortWithArray(list:Array<Int>){
        if list.count < 2 {
            return
        }
        var times = 0//操作次数
        var newlist = list
        
        for i in 0...newlist.count-2 {
            //外层的for循环次数
            for j in 0...newlist.count-i-2 {
                //内层for循环控制交换次数
                let jValue = newlist[j]
                let j1Value = newlist[j+1]
                
                if jValue > j1Value {
                    newlist.swapAt(j, j+1)
                    times = times+1
                }
                
            }
            
        }
        array = newlist
        RYQLog(String(format: "冒泡排序执行次数:%d", times))
        RYQLog(array)
    }
}
