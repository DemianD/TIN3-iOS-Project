//
//  WorkhourRepository.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 18/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class WorkhourRepository {
    
    var workhours = [Workhour]()
    
    private init() {}
    
    func all(completionHandler: @escaping ([Workhour]) -> Void) {
        if(workhours.isEmpty) {
            fetch() {
                self.workhours = $0
                completionHandler($0)
            }
        } else {
            completionHandler(workhours)
        }
    }
    
    func fetch(completionHandler: @escaping ([Workhour]) -> Void) {
        Alamofire.request("http://ios.dev/api/projects/workhours").responseArray(keyPath: "data") { (response: DataResponse<[Workhour]>) -> Void in
            if let workhoursArray = response.result.value {
                completionHandler(workhoursArray);
            }
        }
    }
    
    func save(_ workhour: Workhour, completionHandler: @escaping (Workhour) -> Void) {
        Alamofire.request("http://ios.dev/api/projects/workhours", method: .post, parameters: workhour.toJSON(), encoding: JSONEncoding.default).responseObject(keyPath: "data") { (response: DataResponse<Workhour>) -> Void in

            if let workhour = response.result.value {
                completionHandler(workhour)
            }
        }
    }
    
    static let instance = WorkhourRepository()
}
