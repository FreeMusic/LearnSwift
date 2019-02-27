//
//  HillSortVC.swift
//  算法Demo
//
//  Created by 橘子 on 2019/2/14.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit
/**
 希尔排序(Shell Sort)是插入排序的一种。也称缩小增量排序，是直接插入排序算法的一种更高效的改进版本。希尔排序是非稳定排序算法。
 */
class HillSortVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hillSort()
        RYQLog(array)
        RYQLog(times)
    }

    /**
     希尔排序 时间复杂度----O(n^(3/2))
     */
    func hillSort() {
        
        var j:Int
        var gap = array.count/2
        while gap > 0 {
            
            for i in 0..<gap {
                
                j = i + gap
                while j < array.count {
                    if array[j] < array[j - gap] {
                        let temp = array[j]
                        var k = j - gap
                        while (k>=0 && array[k]>temp) {
                            array[k+gap] = array[k]
                            k -= gap
                            times = times+1
                        }
                        array[k+gap] = temp
                    }
                    j = j+gap
                }
            }
            
            gap = gap/2
        }
        
    }
    
}
