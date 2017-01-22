//
//  NotificationManager.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 22/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager : NSObject, UNUserNotificationCenterDelegate {
    
    let center = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        
        registerActions()
    }
    
    func notify(for category: String, with body: String, every interval: TimeInterval, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = category
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeats)
        
        let request = UNNotificationRequest(
            identifier: "customNotification",
            content: content,
            trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
    }
    
    private func registerActions() {
        // For the timer
        let actionStop = UNNotificationAction(identifier:"stop", title:"Stop",options:[])
        let timer = UNNotificationCategory(identifier: "timer", actions: [actionStop], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([timer])
    }
    
    private func execute(action: String) {
        switch action {
        case "stop":
            TimerManager.instance.toggle()
        default:()
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        execute(action: response.actionIdentifier)
        
        completionHandler()
    }
}
