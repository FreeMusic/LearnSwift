//
//  XYAICreateMLVC.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/8/6.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit

class XYAICreateMLVC: RYQTableViewVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ArithmeticMessages = [
            ArithmeticMessage.init(title: "AI图片学习", class: AIImageCreateMLVC.self),
        ]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let infoMessage = self.ArithmeticMessages[indexPath.row]
        cell?.textLabel?.text = infoMessage.title
        
        return cell!
    }
}
