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
    
    func convertTo(format: String, date: Date?) -> String {
        dateFormatter.dateFormat = format
        
        if let uDate = date {
            return dateFormatter.string(from: uDate)
        }
        return "-"
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
    
    func convertTimeInterval(_ timeInterval: TimeInterval) -> String {
        let seconds = Int(timeInterval)
        
        if timeInterval < 60.0 {
            return String(format: "%.0f sec", timeInterval)
        }
        else {
            let hours = seconds / 3600
            let minutes = (seconds / 60) % 60
            
            return String(format: "%02d:%02d", hours, minutes)
        }
    }
    
    
    func setOnlyDate(from: Date, to: Date) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        
        let componentsFrom = calendar.dateComponents([.year, .month, .day], from: from)
        var componentsTo = calendar.dateComponents([.hour, .minute, .second], from: to)
        
        componentsTo.year = componentsFrom.year
        componentsTo.month = componentsFrom.month
        componentsTo.day = componentsFrom.day
        
        return calendar.date(from: componentsTo)!
    }
    
    func intToString(_ int: Int) -> String {
        return String(format: "%02d", int)
    }
    
    static let instance = DateManager()
}
