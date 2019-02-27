//
//  MergeSortVC.swift
//  算法Demo
//
//  Created by 橘子 on 2019/2/15.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit
/**
    归并排序主要用了分治法的思想，在归并排序中，将我们需要排序的数组进行拆分，将其拆分的足够小。当拆分的数组中只有一个元素时，则这个拆分的数组是有序的。然后我们将这些有序的数组进行两两合并，在合并过程中进行比较，合并生成的新的数组仍然是有序的。然后再次将合并的有序数组进行合并，重复这个过程，直到整个数组是有序的。
 步骤如下：
 1. 申请空间，创建两个数组，长度分别为两个有序数组的长度
 2. 设定两个指针，最初位置分别为两个已经排序序列的起始位置
 3. 比较两个指针所指向的元素，选择相对小的元素放入到合并空间，并移动指针到下一位置
 4. 重复步骤3直到某一指针达到序列尾
 5. 将另一序列剩下的所有元素直接复制到合并序列尾
 */
class MergeSortVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        array = self.mergeSort(arr: &array)
        RYQLog(array)
    }

    /**
     归并排序
     */
    //MARK:- 归并排序
    func mergeSort( arr: inout [Int]) -> [Int] {
        
        func merge ( arr: inout [Int], low: Int, mid: Int, high: Int, temp: inout [Int]) {
            var i = low
            var j = mid + 1
            let m = mid
            let n = high
            var k = 0
            
            while (i <= m && j <= n) {
                if (arr[i] <=  arr[j])
                {
                    temp[k] = arr[i]
                    k += 1
                    i += 1
                }
                else
                {
                    temp[k] = arr[j]
                    k += 1
                    j += 1
                }
            }
            
            while i <= m {
                temp[k] = arr[i]
                k += 1
                i += 1
            }
            
            while j <=  n {
                temp[k] = arr[j]
                k += 1
                j += 1
            }
            
            for f in 0 ..< k {
                arr[low + f] = temp[f]
            }
            
        }
        
        func internalMergeSort( arr: inout [Int], low: Int, high: Int, temp: inout [Int]) {
            if high <= low {
                return
            }
            let mid = low + (high - low) / 2
            // 左边有序
            internalMergeSort(arr: &arr, low: low, high: mid, temp: &temp)
            // 右边有序
            internalMergeSort(arr: &arr, low: mid + 1, high: high, temp: &temp)
            // 将两边合起来
            merge(arr: &arr, low: low, mid: mid, high: high, temp: &temp)
        }
        
        var temp: [Int] = arr// 辅助数组
        internalMergeSort(arr: &arr, low: 0, high: arr.count - 1, temp: &temp)
        return arr
    }

}
