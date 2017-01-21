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
    
    override func delete(_ model: Project, handler: @escaping () -> Void) {
        super.delete(model) {
            let index = self.models.index(where: { $0.id == model.id })
            
            if let index = index {
                self.models.remove(at: index)
            }
            
            WorkhourRepository.instance.deleteWhere(project: model)
            
            handler()
        }
    }
}
