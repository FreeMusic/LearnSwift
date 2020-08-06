//
//  AIImageCreateMLVC.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/8/6.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit

class AIImageCreateMLVC: RYQTableViewVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.ArithmeticMessages = [
                ArithmeticMessage.init(title: "图片对比", class: AnalysisImageModelVC.self),
            ]
        } else {
            
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let infoMessage = self.ArithmeticMessages[indexPath.row]
        cell?.textLabel?.text = infoMessage.title
        
        return cell!
    }
}
