//
//  RealmVC+Insert.swift
//  LearnSwift
//
//  Created by Apple on 2019/8/15.
//  Copyright © 2019 橘子. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 插入部分
extension RealmVC {
    func insertOptions() {
        //测试插入数据
        testInsertStudent()
        //一个学生n本书
        testInsertStudentWithPhotoBook()
        //插入多个学生
        testInsertManyStudent()
    }
    
    func testInsertStudent() {
        let student = Student()
        student.name = "非洲黑汉"
        student.age = 26
        student.id = 3456
        
        let birth = "1945-07-25"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        student.birthday = dateFormatter.date(from: birth)! as NSDate
        
        student.weight = 130
        student.address = "狗屎县屎壳郎乡拖拉机村"
        
        YQStudentRealmTool.insertStudent(by: student, path: student.id)
    }
    
    func testInsertStudentWithPhotoBook() {
        let student = Student()
        student.name = "抠脚大汉"
        student.weight = 145
        student.age = 33
        student.id = 4578
        //头像
        student.photo = (UIImagePNGRepresentation(UIImage.init(named: "MengHuanBackGroundText")!)! as NSData)
        let bookFubaba = Book()
        bookFubaba.name = "富爸爸穷爸爸"
        bookFubaba.author = "[美]罗伯特.T.清崎"
        
        let bookShengmingbuxi = Book()
        bookShengmingbuxi.name = "生命不息, 折腾不止"
        bookShengmingbuxi.author = "罗永浩"
        
        let bookDianfuzhe = Book()
        bookDianfuzhe.name = "颠覆着: 周鸿祎自传"
        bookDianfuzhe.author = "周鸿祎"
        
        student.books.append(bookFubaba);
        student.books.append(bookShengmingbuxi);
        student.books.append(bookDianfuzhe);
        
        YQStudentRealmTool.insertStudent(by: student, path: student.id)
    }
    
    func testInsertManyStudent() {
        
        var students = [Student]()
        
        
        for i in 5689...5700 {
            let student = Student()
            student.name = String.init(format: "搓背壮汉--(%d号)", i)
            student.weight = 115+i
            student.age = 20+i
            student.id = i
            
            students.append(student)
        }
        
        YQStudentRealmTool.insertStudents(by: students, path: 5700)
    }
}
