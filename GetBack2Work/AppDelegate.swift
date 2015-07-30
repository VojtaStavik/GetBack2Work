//
//  AppDelegate.swift
//  GetBack2Work
//
//  Created by Vojta Stavik on 30/07/15.
//  Copyright (c) 2015 STRV. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    
    // MARK: - Push notifications
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
        application.registerForRemoteNotifications()
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        let hub = SBNotificationHub(connectionString: "Endpoint=sb://getback2work.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=BwDJa/I66SKBW2vtBxRpHQ93cAiL+9PiDvmGTWMtWz4=", notificationHubPath: "main")
        
        hub.registerNativeWithDeviceToken(deviceToken, tags: Set([ViewController.userName])) { (error) -> Void in
            
            if let error = error {
                
                println("Error: \(error.localizedDescription)")
                NSNotificationCenter.defaultCenter().postNotificationName(Notifications.NotificationsRegistrationError, object: error)
            }
            
            else {
                
                println("Device registered successfully")
                NSNotificationCenter.defaultCenter().postNotificationName(Notifications.NotificationsRegistrationSuccessfull, object: nil)

            }
        }
    }
}

