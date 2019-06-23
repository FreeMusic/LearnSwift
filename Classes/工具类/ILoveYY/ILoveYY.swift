//
//  ILoveYY.swift
//  LearnSwift
//
//  Created by Apple on 2019/4/10.
//  Copyright © 2019 橘子. All rights reserved.
//

import UIKit

let distanceFuture = 60
var love = 1

class ILoveYY: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        IWantHaveAlongLastingLoveWithYou()
    }
    
    func IWantHaveAlongLastingLoveWithYou() {
        
        var ourBegin = 1
        
        while ourBegin < distanceFuture {
            
            ourBegin = ourBegin + 1

            love = ourBegin*2
        }
        
    }

}
