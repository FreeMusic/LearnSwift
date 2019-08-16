//
//  RealmVC.swift
//  LearnSwift
//
//  Created by Apple on 2019/8/14.
//  Copyright © 2019 橘子. All rights reserved.
//

import UIKit
import RealmSwift

class RealmVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //删除
        self.delete()
        //插入数据
        insertOptions()
        //查询数据
        self.searchStudent()
        //更新数据
        self.updateStudent()
    }
    
}




