//
//  Student.swift
//  LearnSwift
//
//  Created by Apple on 2019/8/15.
//  Copyright © 2019 橘子. All rights reserved.
//

import Foundation
import RealmSwift

///需要注意的是：在使用Realm中存储的数据模型都要是 Object 类的子类。
class Book: Object {
    @objc dynamic var name = ""
    @objc dynamic var author = ""
    
    //反向关系 - LinkingObjects
    let owners = LinkingObjects(fromType: Student.self, property: "books")
}

class Student: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var age = 18
    @objc dynamic var weight = 130
    @objc dynamic var id = 0
    @objc dynamic var address = ""
    @objc dynamic var birthday:NSDate? = nil
    @objc dynamic var photo:NSData? = nil
    
    //重写Object.primaryKey() 可以设置模型的主键
    //声明主键之后，对象将被允许查询，更新速度更加高校，要求每个对象保持唯一性
    //一旦带有主键的对象被添加到Realm之后，该对象的主键将不可更改 设置主键 - primaryKey
    override static func primaryKey() -> String? {
        return "id"
    }
    //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性 忽略属性 - ignoredProperties
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
    
    //重写 Object.indexedProperties() 方法可以为数据模型中需要添加索引的属性建立索引，Realm 支持为字符串、整型、布尔值以及 Date 属性建立索引。 索引属性 - indexedProperties
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    
    //List 用来表示一对多的关系：一个 Student 中拥有多个 Book。 使用List实现一对多关系 - indexedProperties
    var books = List<Book>()
}


/// 工具类
class YQStudentRealmTool: Object {
    
    private class func getRealm(path:Int) -> Realm {
        //传入路径会自动创建数据库
        let studentRealm = try! Realm(fileURL: URL.init(string: studentRealmPath.appendingFormat("%d.realm", path))!)
        
        return studentRealm
    }
    
    /// 插入单条
    public class func insertStudent(by student: Student,  path:Int) -> Void {
        let studentRealm = self.getRealm(path: path)
        try! studentRealm.write {
            studentRealm.add(student)
        }
        RYQLog(studentRealm.configuration.fileURL!)
    }
    
    /// 插入多条
    public class func insertStudents(by students: [Student],  path:Int) -> Void {
        let studentRealm = self.getRealm(path: path)
        try! studentRealm.write {
            studentRealm.add(students)
        }
        RYQLog(studentRealm.configuration.fileURL!)
    }
    /// 获取一个Student数组
    public class func getStudents(from : Int) -> Results<Student> {
        let defaultRealm = self.getRealm(path: from)
        
        return defaultRealm.objects(Student.self)
    }
    
    /// 获取一个Student对象
    public class func getStudent(from: Int) -> Student {
        let defaultRealm = self.getRealm(path: from)
        
        return defaultRealm.object(ofType: Student.self, forPrimaryKey: from)!
    }
    
    /// 获取指定条件的student
    public class func getStudentByTerm(term: String) -> Results<Student>
    {
        let defaultRealm = self.getRealm(path: 5700)
        let predicate = NSPredicate(format: term)
        let results = defaultRealm.objects(Student.self)
        return  results.filter(predicate)
    }
    
//    ///升序降序查询
//    public class func ascendingDescendingQueries() {
//        let defaultRealm = self.getRealm(path: 5700)
//        //根据名字升序查询
//        let ascending = defaultRealm.objects(Student.self).sorted(byKeyPath: "id")
//        // 根据名字降序序查询
//        let descending = defaultRealm.objects(Student.self).sorted(byKeyPath: "id", ascending: false)
//    }
    
    /// 主键更新单个学生
    ///
    /// - Parameters:
    ///   - student: 单个学生
    ///   - id: 主键
    public class func updateStudent(student: Student, id : Int)
    {
        let defaultRealm = self.getRealm(path: id)
        try! defaultRealm.write {
            defaultRealm.add(student, update: true)
        }
    }
    
    /// 主键更新多个学生
    ///
    /// - Parameters:
    ///   - students: 多个学生
    ///   - id: 主键
    public class func updateStudent(students: [Student], id : Int)
    {
        let defaultRealm = self.getRealm(path: id)
        try! defaultRealm.write {
            defaultRealm.add(students, update: true)
        }
    }
    
    /// 更新所有同学的年龄
    ///
    /// - Parameters:
    ///   - from: id
    ///   - age: 年龄
    public class func updateStudentAge(from: Int, age: Int)
    {
        let realm = self.getRealm(path: from)
        
        try! realm.write {
            let students = realm.objects(Student.self)
            students.setValue(age, forKey: "age")
        }
    }
    
    
    /// 删除单个student
    public class func deleteStudent(student:Student, id:Int)
    {
        let realm = self.getRealm(path: id)
        try! realm.write {
            realm.delete(student)
        }
    }
    //删除 多个Student
    public class func deleteStudents(students:Results<Student>, id:Int)
    {
        let realm = self.getRealm(path: id)
        try! realm.write {
            realm.delete(students)
        }
    }
}
