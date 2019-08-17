//
//  RealmVC+Update.swift
//  LearnSwift
//
//  Created by Apple on 2019/8/16.
//  Copyright © 2019 橘子. All rights reserved.
//

import Foundation

// MARK: - 改  更新数据
extension RealmVC {
    
    //更新数据
    func updateStudent() {
        /// 主键更新 - 更新单个学生
        self.updateStudent(idNumber: 4578)
        /// 主键查询
        self.primaryKeySearch(from: 4578)
        
        /// 主键更新 - 更新多个学生
        self.updateManyStudent(idNumber: 5700)
        //普通查询
        self.normalSearch(from: 5700)
        
        //批量更新年龄
        YQStudentRealmTool.updateStudentAge(from: 5700, age:18)
    }
    
    /// 主键更新 - 更新单个学生
    func updateStudent(idNumber : Int) {
        let student = Student()
        student.name = "电车痴汉"
        student.weight = 133
        student.age = 28
        student.id = 4578
        
        let bookShengmingbuxi = Book()
        bookShengmingbuxi.name = "生命不息, 折腾不止"
        bookShengmingbuxi.author = "罗永浩"
        
        let bookDianfuzhe = Book()
        bookDianfuzhe.name = "颠覆着: 周鸿祎自传"
        bookDianfuzhe.author = "周鸿祎"
        
        student.books.append(bookShengmingbuxi);
        student.books.append(bookDianfuzhe);
        
        YQStudentRealmTool.updateStudent(student: student, id: student.id)
    }
    
    /// 主键更新 - 更新多个学生
    func updateManyStudent(idNumber : Int) {
        var students = [Student]()
        
        
        for i in 5689...5700 {
            let student = Student()
            student.name = String.init(format: "抠脚大汉--(%d号)", i)
            student.weight = 115+i-5689
            student.age = 20+i-5689
            student.id = i
            
            students.append(student)
        }
        
        YQStudentRealmTool.updateStudent(students: students, id: 5700)
    }
}
