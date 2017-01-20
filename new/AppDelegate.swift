//
//  AppDelegate.swift
//  blink12_01
//
//  Created by 한민규 on 2016. 12. 1..
//  Copyright © 2016년 Blink. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var nav: UINavigationController?
    var controller: SLPagingViewSwift!
    var startController: loginViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        
        
        let orange = UIColor(red: 255/255, green: 69.0/255, blue: 50/255, alpha: 1.0)
        let gray = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
        
        let ctr1 = scrollViewController()
        ctr1.title = "Ctr1"
        
        let ctr2 = mainController()
        ctr2.title = "Ctr2"
        
        let ctr3 = chattingNav()
        ctr3.title = "Ctr3"
        
        
        var img1 = UIImage(named: "gear")
        img1 = img1?.withRenderingMode(.alwaysTemplate)
        var img2 = UIImage(named: "profile")
        img2 = img2?.withRenderingMode(.alwaysTemplate)
        var img3 = UIImage(named: "chat")
        img3 = img3?.withRenderingMode(.alwaysTemplate)
        
        
        let items = [UIImageView(image: img1), UIImageView(image: img2), UIImageView(image: img3)]
        let controllers = [ctr1, ctr2, ctr3]
        controller = SLPagingViewSwift(items: items, controllers: controllers, showPageControl: false)
        print("체크4")
        
        
        controller.pagingViewMoving = ({ subviews in
            if let imageViews = subviews as? [UIImageView] {
                for i in 0..<3 {
                    var c = gray
                    let originX = imageViews[i].frame.origin.x
                    
                    switch i {
                    case 0:
                        if (originX > 142 * (UIScreen.main.bounds.width / 320) && originX < 330.5 * (UIScreen.main.bounds.width / 320)) {
                            c = self.gradient(originX, topX: 143 * (UIScreen.main.bounds.width / 320), bottomX: 330 * (UIScreen.main.bounds.width / 320), initC: gray, goal: orange)
                        }
                        else if (originX > 0 * (UIScreen.main.bounds.width / 320) && originX < 142 * (UIScreen.main.bounds.width / 320)) {
                            c = self.gradient(originX, topX: 1 * (UIScreen.main.bounds.height / 320), bottomX: 141 * (UIScreen.main.bounds.width / 320), initC: orange, goal: gray)
                        }
                        else if(originX == 142 * (UIScreen.main.bounds.width / 320)){
                            c = orange
                        }
                        imageViews[i].tintColor = c

                    break
                    case 1:
                        if (originX > 460.5 * (UIScreen.main.bounds.width / 320) && originX < 649.0 * (UIScreen.main.bounds.width / 320)) {
                            c = self.gradient(originX, topX: 461 * (UIScreen.main.bounds.width / 320), bottomX: 648 * (UIScreen.main.bounds.width / 320), initC: gray, goal: orange)
                        }
                        else if (originX > 272 * (UIScreen.main.bounds.width / 320) && originX < 460.5 * (UIScreen.main.bounds.width / 320)) {
                            c = self.gradient(originX, topX: 273 * (UIScreen.main.bounds.width / 320), bottomX: 460 * (UIScreen.main.bounds.width / 320), initC: orange, goal: gray)
                        }
                        else if(originX == 460.5 * (UIScreen.main.bounds.width / 320)){
                            c = orange
                        }
                        imageViews[i].tintColor = c
                    break
                    case 2:
                        if (originX > 779 * (UIScreen.main.bounds.width / 320) && originX < 921 * (UIScreen.main.bounds.width / 320)) {
                            c = self.gradient(originX, topX: 780 * (UIScreen.main.bounds.width / 320), bottomX: 920 * (UIScreen.main.bounds.width / 320), initC: gray, goal: orange)
                        }
                        else if (originX > 591 * (UIScreen.main.bounds.width / 320) && originX < 779 * (UIScreen.main.bounds.width / 320)) {
                            c = self.gradient(originX, topX: 592 * (UIScreen.main.bounds.width / 320), bottomX: 778 * (UIScreen.main.bounds.width / 320), initC: orange, goal: gray)
                        }
                        else if(originX == 779 * (UIScreen.main.bounds.width / 320)){
                            c = orange
                        }
                        imageViews[i].tintColor = c
                    break
                    default:
                    break
                    }
                    
                    
                }
                
                /*
                
                for imgView in imageViews {
                    var c = gray
                    let originX = Double(imgView.frame.origin.x)
                    
                    if (originX > 45 && originX < 145) {
                        c = self.gradient(originX, topX: 46, bottomX: 144, initC: orange, goal: gray)
                    }
                    else if (originX > 145 && originX < 245) {
                        c = self.gradient(originX, topX: 146, bottomX: 244, initC: gray, goal: orange)
                    }
                    else if(originX == 145){
                        c = orange
                    }
                    imgView.tintColor = c
 
                
                }
                */
            }
        })
        
        //self.nav = UINavigationController(rootViewController: self.controller)
        self.window?.rootViewController = self.controller
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        
        
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
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
    
    func viewWithBackground(_ color: UIColor) -> UIView{
        let v = UIView()
        v.backgroundColor = color
        return v
    }
    
    func gradient(_ percent: CGFloat, topX: CGFloat, bottomX: CGFloat, initC: UIColor, goal: UIColor) -> UIColor{
        let t = (percent - bottomX) / (topX - bottomX)
        
        let cgInit = initC.cgColor.components
        let cgGoal = goal.cgColor.components
        
        let r_last = ((cgGoal?[0])! - (cgInit?[0])!)
        let g_last = ((cgGoal?[1])! - (cgInit?[1])!)
        let b_last = ((cgGoal?[2])! - (cgInit?[2])!)
        
        let r = (cgInit?[0])! + (CGFloat(t)) * r_last
        let g = (cgInit?[1])! + CGFloat(t) * g_last
        let b = (cgInit?[2])! + CGFloat(t) * b_last
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
    
}

