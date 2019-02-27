//
//  InsertionSortVC.swift
//  算法Demo
//
//  Created by 橘子 on 2019/2/14.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

/**
 插入排序算是比较好理解的排序方式，插入排序也是将要排序的数列分为两部分，前半部分是已经排好序的，后半部分则是无序的。插入排序中的插入是指“取出无序数列中第一个值，插入到有序数列中相应的位置”。其实这个插入过程也是不断比较和交换的过程。
 每一轮插入都会取出无序数列中的第一个元素插入到有序数列中，这个插入的过程其实就是一个比较交换的过程，如果要插入的值比前面的值要小，就要交换，直到不能交换为止。下方就是插入排序的过程。
 */

class InsertionSortVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.insertSort()
        RYQLog(array)
        RYQLog(String(format: "插入排序执行次数:%d", times))
    }
    /**
     插入排序  时间复杂度----O(n^2)
     */
    func insertSort()  {
        
        for i in 1..<array.count {//第一位元素肯定是一个有序数组。从第二位开始遍历。
            
            var j : Int = i - 1
            //i（也是j+1）要插入的元素，0到j之间的是有序数组。下面的遍历就是要把插入的元素j+1,插入到有序数组中
            while j >= 0 {
                if array[j] > array[j+1] {
                    array.swapAt(j, j+1)
                    times = times+1
                }
                
                j = j-1
            }
        }
        
    }
}
