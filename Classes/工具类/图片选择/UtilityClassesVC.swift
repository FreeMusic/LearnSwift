//
//  UtilityClassesVC.swift
//  LearnSwift
//
//  Created by 橘子 on 2019/3/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class UtilityClassesVC: RYQTableViewVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.ArithmeticMessages = [
            ArithmeticMessage.init(title: "图片选择", class: PictureSelectVC.self),
            ArithmeticMessage.init(title: "大图浏览", class: PhotoBrowseVC.self),
            ArithmeticMessage.init(title: "I Love YY", class: ILoveYY.self),
        ]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let infoMessage = self.ArithmeticMessages[indexPath.row]
        cell?.textLabel?.text = infoMessage.title
        
        return cell!
    }

}
