//
//  RealmVC+Search.swift
//  LearnSwift
//
//  Created by Apple on 2019/8/15.
//  Copyright © 2019 橘子. All rights reserved.
//

import Foundation

// MARK: - 查询数据
extension RealmVC {
    //所有查询
    func searchStudent() {
        //普通查询
        self.normalSearch()
        /// 主键查询
        primaryKeySearch()
    }
    
    /// 普通查询
    func normalSearch() {
        
        let students = YQStudentRealmTool.getStudents()
        
        for stu in students {
            RYQLog(stu.name);
        }
    }
    
    /// 主键查询
    func primaryKeySearch() {
        let student = YQStudentRealmTool.getStudents(from: 5700)
        RYQLog(student.name)
    }
    
}
