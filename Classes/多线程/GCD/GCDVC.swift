//
//  GCDVC.swift
//  算法Demoemo
//
//  Created by 橘子 on 2019/2/26.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit
/**
 简介
 Grand Central Dispatch (GCD) 是Apple开发的一个多核编程的较新的解决方法。它主要用于优化应用程序以支持多核处理器以及其他对称多处理系统。
 众所周知，GCD, NSOperationQueue, NSThread, pthread是iOS中多线程的几种处理方式，Swift3之前GCD仍是面向过程的写法，所以需要封装一层再使用。Swift3苹果打成Dispatch这个module.你可以通过import进行导入再使用。Swift4，直接使用。
 特性
 GCD可用于多核的并行运算
 GCD会自动利用更多的CPU内核（比如双核、四核）
 GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）
 */
class GCDVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //异步执行回主线程写法
//        asynchronousExecutionBackToTheMainThread()
        //多个网络请求同时发出去，等网络请求都完成后reload UI。
//        dispatchGroupManngerNetWorkTaskThenReFreshUI()
        //添加阻碍 Barrier
        dispatchGroupManngerAddBarrier()
    }
    
}

extension GCDVC {
    /**
     异步执行回主线程写法
     */
    func asynchronousExecutionBackToTheMainThread() {
        DispatchQueue.global().async {
            RYQLog("异步线程执行操作")
            sleep(1)
            DispatchQueue.main.async {
                RYQLog("主线程执行操作")
            }
            
        }
    }
    /**
     DispatchGroup用来管理一组任务的执行，然后监听任务都完成的事件。比如，多个网络请求同时发出去，等网络请求都完成后reload UI。
     */
    func dispatchGroupManngerNetWorkTaskThenReFreshUI() {
        
        let group = DispatchGroup()
        //指示要进入耗时操作的模块 enter leave 手动管理group计数,enter和leave必须配对
        group.enter()
        //模拟耗时操作
        DispatchQueue.global().async {
            sleep(1)
            RYQLog("任务1执行完成")
            //指示耗时操作中的该模块已经执行完毕
            group.leave()
        }
        //指示要进入耗时操作的模块
        group.enter()
        //模拟耗时操作
        DispatchQueue.global().async {
            sleep(10)
            RYQLog("任务10执行完成")
            //指示耗时操作中的该模块已经执行完毕
            group.leave()
        }
        //依赖任务 依赖耗时操作执行完 再回到主线程执行任务
        group.notify(queue: DispatchQueue.main) {
            RYQLog("任务已经全部执行完成")
        }
    }
    /**
     添加阻碍 Barrier GCD里的Barrier和NSOperationQueue的dependency比较接近，C任务开始之前需要A任务完成，或者A和B任务完成。
     */
    func dispatchGroupManngerAddBarrier() {
        
    }
}
