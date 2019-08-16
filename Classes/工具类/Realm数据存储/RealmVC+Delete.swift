//
//  RealmVC+Delete.swift
//  LearnSwift
//
//  Created by Apple on 2019/8/16.
//  Copyright © 2019 橘子. All rights reserved.
//

import Foundation

// MARK: - 删除
extension RealmVC {

    func delete() {
        //单个删除
        self.deleteSingle()
        //多个删除
        self.deleteGroup()
    }
    
    /// 单个删除
    func deleteSingle() {
        
        let student = YQStudentRealmTool.getStudent(from: 4578)
        let student1 = YQStudentRealmTool.getStudent(from: 3456)
        
        YQStudentRealmTool.deleteStudent(student: student1, id: 3456)
        YQStudentRealmTool.deleteStudent(student: student, id: 4578)
    }
    
    /// 多个删除
    func deleteGroup()  {
        let students = YQStudentRealmTool.getStudents(from: 5700)
        
        YQStudentRealmTool.deleteStudents(students: students, id: 5700)
    }
}
