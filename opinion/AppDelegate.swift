//
//  AppDelegate.swift
//  CEREBRUS MAXIMUS
//
//  Created by Jack Blair on 11/16/23.
//

import Foundation
import UIKit
import UserNotifications
import FirebaseCore
import FirebaseMessaging

extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        if let deepLink = userInfo["deeplink"] as? String {
            handleDeepLink(deepLink)
        }

        // Change this to your preferred presentation option
        return [.banner, .badge, .sound, .list]
    }


  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
                                  
      switch response.actionIdentifier {
         case "queryHuman.respondAction":
            print("Respond")
              
         case "queryHuman.ignoreAction":
            print("Ignore")
              
         // Handle other actions…
       
         default:
          print("Weird")
         }

    // [START_EXCLUDE]
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    // [END_EXCLUDE]

    // With swizzling disabled you must let Messaging know about the message, for Analytics
     Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)
      
//      if let deepLink = userInfo["deeplink"] as? String {
//          handleDeepLink(deepLink)
//      }
      
//          if UIApplication.shared.applicationState == .background || UIApplication.shared.applicationState == .inactive {
//              NotificationCenter.default.post(name: .init(rawValue: "NEW"), object: nil, userInfo:userInfo)
//           }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  NotificationCenter.default.post(name: NSNotification.Name("NotificationReceived"), object: nil, userInfo: userInfo)
              }

      
      completionHandler()

  }
    


}

// [END ios_10_message_handling]

extension AppDelegate: MessagingDelegate {
  // [START refresh_token]
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")

    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: dataDict
    )
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
      
//      APIService.shared.setNotificationToken(notificationToken: fcmToken ?? "") { success in
//          print(success)
//      }
  }

  // [END refresh_token]
}




class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  let gcmMessageIDKey = "gcm.message_id"

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication
                     .LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
                         let currentCount = UserDefaults.standard.integer(forKey: "launchCount")
                         UserDefaults.standard.set(currentCount+1, forKey: "launchCount")
    
                         


     // [START set_messaging_delegate]
         Messaging.messaging().delegate = self
         // [END set_messaging_delegate]
                    
                              
//         RemoteConfigManager.shared.fetchConfig()

    // Register for remote notifications. This shows a permission dialog on first run, to
    // show the dialog at a more appropriate time move this registration accordingly.
    // [START register_for_notifications]
     
     UNUserNotificationCenter.current().delegate = self
                         
// For NOW!!!
//     let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//     UNUserNotificationCenter.current().requestAuthorization(
//       options: authOptions,
//       completionHandler: { _, _ in }
//     )

     application.registerForRemoteNotifications()
//     Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
                         
    // [END register_for_notifications]
                         
      let respondAction = UNNotificationAction(identifier: "queryHuman.respondAction", title: "Respond", options: [], icon: UNNotificationActionIcon(systemImageName: "message"))
      let ignoreAction = UNNotificationAction(identifier: "queryHuman.ignoreAction", title: "Ignore", options: [], icon: UNNotificationActionIcon(systemImageName: "xmark.circle"))
 
      let QueryHumanNotificationCategory = UNNotificationCategory(
          identifier: "QueryHuman",
          actions: [respondAction, ignoreAction],
          intentIdentifiers: [],
          options: .customDismissAction)
 
                         let notificationCenter = UNUserNotificationCenter.current()
                         notificationCenter.setNotificationCategories([QueryHumanNotificationCategory])

    return true
  }
    
  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)
      
      // Handle deep linking here
      if let deepLink = userInfo["deeplink"] as? String {
          handleDeepLink(deepLink)
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          NotificationCenter.default.post(name: NSNotification.Name("RemoteNotificationReceived"), object: nil, userInfo: userInfo)
      }
      
      if let badgeNumber = userInfo["badge"] as? Int {
              application.applicationIconBadgeNumber += 1
          }

  }
    
    // Function to handle deep linking
    private func handleDeepLink(_ deepLink: String) {
        print(deepLink)
        // Handle the deep link URL here
        // You can navigate to a specific view or perform any other action based on the deep link
        // For example, you can use a URL scheme or a custom URL to navigate to a specific screen in your app
    }

  // [START receive_message]
  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
    -> UIBackgroundFetchResult {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)
        
        // Handle deep linking here
        if let deepLink = userInfo["deepLink"] as? String {
            handleDeepLink(deepLink)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            NotificationCenter.default.post(name: NSNotification.Name("RemoteNotificationReceived"), object: nil, userInfo: userInfo)
        }
        
        let currentBadgeNumber = application.applicationIconBadgeNumber
        application.applicationIconBadgeNumber = currentBadgeNumber + 1


    return UIBackgroundFetchResult.newData
  }

  // [END receive_message]

  func application(_ application: UIApplication,
                   didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Unable to register for remote notifications: \(error.localizedDescription)")
  }

  // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
  // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
  // the FCM registration token.
  func application(_ application: UIApplication,
                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("APNs token retrieved: \(deviceToken)")

    // With swizzling disabled you must set the APNs token here.
//     Messaging.messaging().apnsToken = deviceToken
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
