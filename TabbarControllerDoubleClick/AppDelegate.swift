//
//  AppDelegate.swift
//  TabbarControllerDoubleClick
//
//  Created by 杨胜浩 on 16/6/23.
//  Copyright © 2016年 chuqingr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    var tabbarController = UITabBarController()
    var lastDate = NSDate()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        initTabbar()
        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    
    
    func initTabbar(){
        let communityController = UINavigationController(rootViewController: ViewController())
        let mallsController = UINavigationController(rootViewController: AViewController())
        let mineController = UINavigationController(rootViewController: BViewController())
        tabbarController.viewControllers = [communityController,mallsController,mineController]
        /**  设置tabbar的颜色和透明度 */
        tabbarController.tabBar.backgroundColor = UIColor.whiteColor()
        tabbarController.tabBar.translucent = false
        tabbarController.delegate = self
        /**  设置文字距离底部的距离 */
        let offset = UIOffsetMake(0, -3)
        //        let tabbarItem1 = UITabBarItem(title: "首页", image: UIImage(named: "home_Normal"), selectedImage: UIImage(named: "home_Selected"))
        //        tabbarItem1.tag = 0
        //        tabbarItem1.titlePositionAdjustment = offset
        
        //        let tabbarItem2 = UITabBarItem(title: "首页2", image: UIImage(named: "grass_Normal"), selectedImage: UIImage(named: "grass_Selected"))
        //        tabbarItem2.tag = 2
        //        tabbarItem2.titlePositionAdjustment = offset
        
        let tabbarItem3 = UITabBarItem(title: "社区", image: UIImage(named: "community_Normal"), selectedImage: UIImage(named: "community_Selected"))
        tabbarItem3.tag = 0
        tabbarItem3.titlePositionAdjustment = offset
        
        let tabbarItem4 = UITabBarItem(title: "商城", image: UIImage(named: "malls_Normal"), selectedImage: UIImage(named: "malls_Selected"))
        tabbarItem4.titlePositionAdjustment = offset
        tabbarItem4.tag = 1
        
        let tabbarItem5 = UITabBarItem(title: "我的", image: UIImage(named: "mine_normal"), selectedImage: UIImage(named: "mine_Selected"))
        tabbarItem5.tag = 2
        tabbarItem5.titlePositionAdjustment = offset
        
        
        //        homeController.tabBarItem = tabbarItem1
        //        growGrassController.tabBarItem = tabbarItem2
        communityController.tabBarItem = tabbarItem3
        mallsController.tabBarItem = tabbarItem4
        mineController.tabBarItem = tabbarItem5
        
        
        
        
    }
    
    //MARK: -- uitabbarcontrollerDelegate
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool{
        let vc = tabBarController.selectedViewController
        let date = NSDate()
        if vc == viewController {
            if date.timeIntervalSince1970 - lastDate.timeIntervalSince1970 <= 0.5 {
                let vc = (viewController as! UINavigationController).viewControllers.first
                switch tabbarController.selectedIndex {
                case 0:
                    (vc as! ViewController).tableView?.mj_header.beginRefreshing()
                case 1:
                    (vc as! AViewController).tableView?.mj_header.beginRefreshing()
                default:
                    (vc as! BViewController).tableView?.mj_header.beginRefreshing()
                }
                //如果双击，就将lastDate置成一个较小的值，防止多次重复点击造成的方法重复调用
                lastDate = NSDate(timeIntervalSinceReferenceDate:1000)
            }else {
                //如果不是双击，记录最后一次点击时间
                lastDate = date
            }
            return false
        }else {
            //如果换了按钮点击，记录下最后一次点击时间
            lastDate = date
        }
        return true
    }

    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

