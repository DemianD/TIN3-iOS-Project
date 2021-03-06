//
//  Workhour.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 18/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

class Workhour : Mappable
{
    var id = -1
    
    var description: String?
    var location: String?
    var start: Date?
    var stop: Date?
    
    var project_id = -1
    
    var latitude = 0.0
    var longitude = 0.0
    
    var project: Project? {
        return ProjectRepository.instance.find(project_id)
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        
        description <- map["description"]
        location <- map["location"]
        
        project_id <- map["project_id"]
        
        // Map when it's a timestamp
        start <- (map["start"], DateTransform())
        stop <- (map["stop"], DateTransform())
        
        // Map when it's a MysqlDate
        if let mysqlDate = DateManager.instance.convertMysql(map["start"].currentValue) {
            start = mysqlDate
        }
        if let mysqlDate = DateManager.instance.convertMysql(map["stop"].currentValue) {
            stop = mysqlDate
        }
        
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
    
    func isStarted() -> Bool {
        return start != nil
    }
    
    func getDay() -> String {
        return DateManager.instance.convertTo(format: "DD-MM-YYYY", date:start)
    }
    
    func getStartTime() -> String {
        return DateManager.instance.convertToTimeMinutes(start)
    }
    
    func getStopTime() -> String {
        return DateManager.instance.convertToTimeMinutes(stop)
    }
    
    func getInterval() -> String {
        if let startDate = start, let stopDate = stop {
            return DateManager.instance.convertTimeInterval(stopDate.timeIntervalSince(startDate))
        }
        return "-"
    }
    
    func csvRow() -> String {
        return "\(getDay());\(getStartTime());\(getStopTime());\(getInterval())\n"
    }
}
