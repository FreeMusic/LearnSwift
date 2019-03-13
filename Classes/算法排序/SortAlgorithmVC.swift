//
//  SortAlgorithmVC.swift
//  Swift学习记录
//
//  Created by 橘子 on 2019/2/26.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class SortAlgorithmVC: RYQTableViewVC {


    override func viewDidLoad() {
        super.viewDidLoad()

        self.ArithmeticMessages = [
            ArithmeticMessage.init(title: "冒泡排序", class: BubbleSortVC.self),
            ArithmeticMessage.init(title: "快速排序", class: QuickSortVC.self),
            ArithmeticMessage.init(title: "插入排序", class: InsertionSortVC.self),
            ArithmeticMessage.init(title: "希尔排序", class: HillSortVC.self),
            ArithmeticMessage.init(title: "选择排序", class: SelectionSortVC.self),
            ArithmeticMessage.init(title: "归并排序", class: MergeSortVC.self),
            ArithmeticMessage.init(title: "堆排序", class: HeapSortVC.self),
            ArithmeticMessage.init(title: "递归算法", class: RecursiveVC.self),
        ]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let infoMessage = self.ArithmeticMessages[indexPath.row]
        cell?.textLabel?.text = infoMessage.title
        
        return cell!
    }
}
