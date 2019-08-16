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
        self.normalSearch(from: 5700)
        /// 主键查询
        self.primaryKeySearch(from: 5700)
        //条件查询
        self.termKeySearch()
    }
    
    /// 普通查询
    func normalSearch(from: Int) {
        
        let students = YQStudentRealmTool.getStudents(from: from)
        
        for stu in students {
            RYQLog(stu.name);
        }
    }
    
    /// 主键查询
    func primaryKeySearch(from: Int) {
        let student = YQStudentRealmTool.getStudent(from: from)
        RYQLog(student.name)
    }
    
    /// 条件查询
    func termKeySearch() {
        let students = YQStudentRealmTool.getStudentByTerm(term: "name = '搓背壮汉--(5698号)'")
        if students.count == 0 {
            RYQLog("未查找到任何数据")
            return
        }
        for stu in students {
            RYQLog(stu.age+stu.id)
        }
    }
}
