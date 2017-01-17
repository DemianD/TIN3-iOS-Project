//
//  Project.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 27/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import Foundation
import ObjectMapper

class Project : Mappable
{
    
    var statuses = [
        Status.Ok: "Alles is oké",
        .SslExpired: "Ssl is vervallen",
        .Unreachable: "Website is niet bereikbaar"
    ]
 
    var id = -1;
    var name: String?
    var url: String?
    
    var status: Status?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
    }
    
    
    var statusMessage: String {
        get {
            if let status = self.status {
                return statuses[status] ?? statuses[.Ok]!
            } else {
                return statuses[.Ok]!
            }
        }
    }
 
}
