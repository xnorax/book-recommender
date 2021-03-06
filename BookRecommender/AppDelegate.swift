//
//  AppDelegate.swift
//  BookRecommender
//
//  Created by Nora AlNashwan on 3/24/18.
//  Copyright © 2018 Nora AlNashwan. All rights reserved.
//

import UIKit
import SwifteriOS
import PersonalityInsightsV3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var swifter:Swifter?
    var personalityInsights:PersonalityInsights?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

            swifter = Swifter(consumerKey:localized(key: "twitterKey"), consumerSecret:localized(key:"twitterSecret"), oauthToken: localized(key:"oauthToken"), oauthTokenSecret:localized(key:"oauthTokenSecret"))
        personalityInsights = PersonalityInsights(username: localized(key: "serviceUsername"), password: localized(key: "servicePassword"), version: "2018-03-28")
        
        return true
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
    
    func localized(key:String) -> String {
        return NSLocalizedString(key, comment: "")
    }


}

