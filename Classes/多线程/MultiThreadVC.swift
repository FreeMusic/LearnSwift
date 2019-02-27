//
//  MultiThreadVC.swift
//  Swift学习记录
//
//  Created by 橘子 on 2019/2/26.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class MultiThreadVC: RYQTableViewVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.ArithmeticMessages = [
            ArithmeticMessage.init(title: "GCD", class: GCDVC.self),
        ]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let infoMessage = self.ArithmeticMessages[indexPath.row]
        cell?.textLabel?.text = infoMessage.title
        
        return cell!
    }

}
