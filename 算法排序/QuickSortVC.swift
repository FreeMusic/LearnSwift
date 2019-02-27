//
//  QuickSortVC.swift
//  排序算法Demo
//
//  Created by 橘子 on 2019/1/24.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit
/**
 快速排序的基本步骤（从小到大）：
 
 在数列中选择一个数作为基准数（pivot）。
 遍历整个数列，将所有小于基准数的数字移到基准数的左边，将所有大于基准数的数字移到基准数的右边。
 以基准数为界，将原数列截成左右两个数列。
 不断重复上述三个步骤来分别处理生成的两个数列，直到每个生成的数列只剩下一个数字。
 
 在上述操作过程中，我们用到了分治和递归的思想。
 */
class QuickSortVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         *  示例代码
         */
        quickSortNumber(left: 0, right: array.count-1)
        RYQLog(array)
        RYQLog(String(format: "快速排序执行次数:%d", times))
        
    }
    
}

extension QuickSortVC {
    
    func quickSortNumber(left: Int, right : Int) -> Void {
        
        var i, j, pivot : Int
        
        if left > right {
            return
        }
        
        pivot = array[left]
        
        i = left
        j = right
        
        while i != j {
            
            while array[j] >= pivot && i < j {
                j -= 1
            }
            
            while array[i] <= pivot && i < j {
                i += 1
            }
            
            if i < j {
                array.swapAt(i, j)
                times = times+1
            }
        }
        
        array[left] = array[i]
        array[i] = pivot
        
        //二分
        quickSortNumber(left: left, right: i - 1)
        quickSortNumber(left: i + 1, right: right)
    }
    
}
