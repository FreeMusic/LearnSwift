//
//  AppDelegate.swift
//  LearnSwift
//
//  Created by 橘子 on 2019/2/27.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

@available(iOS 11.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let naviVC = UINavigationController.init(rootViewController: ViewController())
        
        self.window?.rootViewController = naviVC
        let string = "hello!"
        print(string)
        let `class` = "Runoob"
        let a = 1 + 2;
        var optionalInteger: Int?
        optionalInteger = 234;
        print(optionalInteger as Any)
        
        //Realm的环境配置
//        AppDelegate.configureRealm()
        // Override point for customization after application launch.
        return true
    }
    
    /// Realm的环境配置
    public class func configureRealm() {
        //如果要存储的数据模型属性发生变化，需要配置当前版本号比之前大
        let realmVersion: UInt64 = 2
        let config = Realm.Configuration(fileURL: URL.init(string: studentRealmPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: realmVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm{
                RYQLog("Realm 服务器配置成功!")
            }else if let error = error {
                RYQLog("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
/*
 总结：自定义Log：
 v定义Log 1. 定义Log的打印内容
 打印所在的 件 #FILE 打印所在的方法 #FUNCTION 打印所在的行 #LINE
 默认参数：当在方法中传参数时，也可以传入默认参数，定义：file : String = #file
 全局函数：在AppDelegate中定义全局函数：泛型传打印内容：func XMGLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line)
 2.Log在Debug下 打印,在release下 不打印
 定义标记项 —>buildSettings—>搜索swift flag—>Debug -> -D DEBUG 做标记--------在项目中实现：#if DEBUG    #endif
 
 */

func RYQLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    let fileName = (file as NSString).lastPathComponent
    print("所在控制器:\(fileName);  行数:(\(lineNum));  方法名:\(funcName);  打印结果:\n\(messsage)")
    
}


