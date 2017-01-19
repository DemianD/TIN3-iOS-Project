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
 
    // Source: https://developer.apple.com/ios/human-interface-guidelines/visual-design/color/
    var colors = [
        "Red": UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0),
        "Orange": UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0),
        "Yellow": UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0),
        "Green": UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0),
        "TealBlue": UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0),
        "Blue": UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0),
        "Purple": UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1.0),
        "Pink": UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1.0),
    ]
    
    var id = -1;
    var name: String?
    var url: String?
    var colorName: String?
    var pricePerHour = 0.0
    
    // Computed property
    var color: UIColor {
        if let name = colorName {
            return colors[name]!
        }
        return UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
    }
    
    var status: Status?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
        colorName <- map["color"]
        pricePerHour <- map["pricePerHour"]
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
