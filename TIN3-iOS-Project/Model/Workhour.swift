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
        
        start <- (map["start"], DateTransform())
        stop <- (map["stop"], DateTransform())
        
        project_id <- map["project_id"]
        user_id <- map["user_id"]
    }
    
    func isStarted() -> Bool {
        return start != nil
    }
}
