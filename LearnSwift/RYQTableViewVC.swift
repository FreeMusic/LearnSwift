//
//  RYQTableViewVC.swift
//  Swift学习记录
//
//  Created by 橘子 on 2019/2/26.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class RYQTableViewVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: NavigationBarHeight, width: kScreenWidth, height: kScreenHeight-NavigationBarHeight), style: UITableViewStyle.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.view.addSubview(tableView!)
    }

}
extension RYQTableViewVC {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArithmeticMessages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoMessage = self.ArithmeticMessages[indexPath.row]
        let vcClass = infoMessage.class as? UIViewController.Type
        let vc = vcClass!.init()
        vc.title = infoMessage.title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
