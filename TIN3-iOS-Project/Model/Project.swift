//
//  Project.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 27/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import Foundation

class Project
{
    
    var statuses = [
        Status.Ok: "Alles is oké",
        .SslExpired: "Ssl is vervallen",
        .Unreachable: "Website is niet bereikbaar"
    ]
 
    var name: String
    var status: Status?
    
    init(_ name: String) {
        self.name = name
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
