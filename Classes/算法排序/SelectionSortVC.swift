//
//  SelectionSortVC.swift
//  算法Demo
//
//  Created by 橘子 on 2019/2/14.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

/**
 选择排序
 目标：将一个数组按从小到大或从大到小的顺序排序好。
 当我们得到一个数组，然后需要将数组内容按照一定顺序排序好，选择排序算法可以将该数组分成两部分，一边是排序好的部分，另一边是还没排序好的部分。
 
 选择排序算法具体流程如下：
 1.从index=0开始，遍历整个数组，找到数组中的最小值
 2.将最小值与index=0的数字交换位置。现在，在已排序部分中只包含了index=0的数字
 3.从index=1开始，遍历剩余整个数组，找到数组中的最小值
 4.将最小值与index=1的数字交换位置。现在，在已排序部分中包含了index为0，1的两个数字
 5.从index=2开始，遍历剩余整个数组，找到最小值并与index=2的数字交换位置。
 6.重复上述过程直到完成数组排序。
 
 总体来说，选择排序是一种就地排序，因为整个过程都发生在同一个数组内，没有用到更多的内存。
 */
class SelectionSortVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectionSort()
        RYQLog(array)
    }

    /**
     选择排序
     */
    func selectionSort() {
        
        for i in 0 ..< array.count - 1 {
            var min = i
            for j  in i+1 ..< array.count {
                if array[min] > array[j] {
                    min = j
                }
            }
            let temp = array[min]
            array[min] = array[i]
            array[i] = temp
        }
    }
}
