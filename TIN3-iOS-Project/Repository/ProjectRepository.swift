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

class ProjectRepository : BaseRepository<Project> {
    static let instance = ProjectRepository()
    
    private init() {
        super.init("projects")
    }
    
    func find(_ id : Int) -> Project? {
        return models.first(where: { $0.id == id })
    }
}
