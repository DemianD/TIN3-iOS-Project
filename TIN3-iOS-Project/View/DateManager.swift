//
//  DateManager.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 20/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import Foundation

class DateManager {
    
    let dateFormatter = DateFormatter()
    let calendar = Calendar.current
    
    private init() {
        
    }
    
    func convertMysql(_ anyObject: Any?) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let dateString = anyObject as? String, let startFormat = dateFormatter.date(from: dateString)  {
            return startFormat
        }
        return nil
    }
    
    func convertToTimeMinutes(_ date: Date?) -> String {
        if let date = date {
            let hour = intToString(calendar.component(.hour, from: date))
            let minutes = intToString(calendar.component(.minute, from: date))
        
            return "\(hour):\(minutes)"
        }
        
        return "-"
    }
    
    func convertToSectionName(_ date: Date?) -> String {
        dateFormatter.dateFormat = "E dd MMM"
        
        if let uDate = date {
            return dateFormatter.string(from: uDate)
        }
        
        return "-"
    }
    
    func intToString(_ int: Int) -> String {
        return String(format: "%02d", int)
    }
    
    static let instance = DateManager()
}
