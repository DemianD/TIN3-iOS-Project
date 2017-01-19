//
//  Workhour.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 18/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import Foundation
import ObjectMapper

class Workhour : Mappable
{
    var id = -1
    
    var description: String?
    var location: String?
    var start: Date?
    var stop: Date?
    
    var project_id = -1
    var user_id = 1 // TODO: use real user account
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        
        description <- map["description"]
        location <- map["location"]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        start <- (map["start"], DateTransform())
        
        if let dateString = map["start"].currentValue as? String, let startFormat = dateFormatter.date(from: dateString) {
            start = startFormat
        }
        
        if let dateString = map["stop"].currentValue as? String, let stopFormat = dateFormatter.date(from: dateString) {
            stop = stopFormat
        }
        
        project_id <- map["project_id"]
        user_id <- map["user_id"]
    }
    
    func isStarted() -> Bool {
        return start != nil
    }
    
    func getStartTime() -> String {
        let calendar = Calendar.current
        
        if let startDate = start {
            let hour = calendar.component(.hour, from: startDate)
            let minutes = calendar.component(.minute, from: startDate)
            
            return "\(hour):\(minutes)"
        }
        else {
            return ""
        }
    }
    
    func getStopTime() -> String {
        let calendar = Calendar.current
        
        if let stopDate = stop {
            let hour = calendar.component(.hour, from: stopDate)
            let minutes = calendar.component(.minute, from: stopDate)
            
            return "\(hour):\(minutes)"
        }
        else {
            return ""
        }
    }
    
    
}
