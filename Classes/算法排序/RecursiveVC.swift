//
//  RecursiveVC.swift
//  LearnSwift
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class RecursiveVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sum = self.add(n: 100)
        
        RYQLog(sum)
    }
    
    func add(n:Int) -> Int {
        
        var sum = 0
        
        if n > 0 {
            sum = n + add(n: n-1)
        }else{
            sum = 0
        }
        
        return sum
    }

}
