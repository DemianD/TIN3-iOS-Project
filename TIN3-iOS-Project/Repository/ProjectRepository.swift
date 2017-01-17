//
//  ProjectRepository.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 17/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ProjectRepository {
    
    //Source: https://krakendev.io/blog/the-right-way-to-write-a-singleton
    static let instance = ProjectRepository()
    
    private init() {}
    
    // Source for escape and why: http://stackoverflow.com/questions/38990882/closure-use-of-non-escaping-parameter-may-allow-it-to-escape
    func all(completionHandler: @escaping ([Project]) -> Void) {
        Alamofire.request("http://ios.dev/api/projects").responseArray(keyPath: "data") { (response: DataResponse<[Project]>) -> Void in
            if let projectArray = response.result.value {
                completionHandler(projectArray);
            }
        }
    }
}
