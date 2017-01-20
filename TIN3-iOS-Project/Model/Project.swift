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
    private var colors = Colors.dictionary
    
    var id = -1;
    
    var name: String?
    var url: String?
    var colorName: String?
    var pricePerHour = 0.0
    
    var color: UIColor {
        if let name = colorName {
            return colors[name]!
        }
        return Colors.standard
    }
    
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
}
