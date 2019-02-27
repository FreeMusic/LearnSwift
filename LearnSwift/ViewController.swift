//
//  ViewController.swift
//  LearnSwift
//
//  Created by 橘子 on 2019/2/27.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class ViewController: RYQTableViewVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift学习记录"
        self.ArithmeticMessages = [
            ArithmeticMessage.init(title: "算法排序", class: SortAlgorithmVC.self),
            ArithmeticMessage.init(title: "多线程", class: MultiThreadVC.self),
            ArithmeticMessage.init(title: "贝塞尔曲线和Layer画图", class: CurveDrawVC.self),
            ArithmeticMessage.init(title: "数据结构", class: DataStructureVC.self),
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let infoMessage = self.ArithmeticMessages[indexPath.row]
        cell?.textLabel?.text = infoMessage.title
        
        return cell!
    }
    
    
}


