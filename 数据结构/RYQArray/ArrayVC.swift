//
//  ArrayVC.swift
//  算法Demoemo
//
//  Created by 橘子 on 2019/2/20.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class ArrayVC: BaseViewController {
    
    var arrayList:RYQArray<NSString>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrayList = RYQArray.init(capacity: 1)
        arrayList.add("第三去问问方")
        arrayList.add("第三23423方")
        arrayList.add("第如同三方")
        arrayList.add("第三尔特方")
        arrayList.add("第儿童热帖三方")
        
        RYQLog(arrayList)
        arrayList.remove("第儿童热帖三方")
        RYQLog(arrayList)
        
        arrayList.replaceObject(at: 3, with: "被替换的元素")
        RYQLog(arrayList)
    }

}
