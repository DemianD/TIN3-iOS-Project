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

class WorkhourRepository : BaseRepository<Workhour> {
    
    private init() {
        super.init("projects/workhours")
    }
    
    func all(project: Project, withRefresh refresh: Bool = false, handler: @escaping ([Workhour]) -> Void) {
        
        if !models.isEmpty && !refresh {
            return handler(models.filter({ $0.project_id == project.id }))
        }

        super.all(withRefresh: refresh) {
            return handler($0.filter({ $0.project_id == project.id }))
        }
    }
    
    override func delete(_ model: Workhour, handler: @escaping () -> Void) {
        super.delete(model) {
            let index = self.models.index(where: { $0.id == model.id })
            
            if let index = index {
                self.models.remove(at: index)
            }

            handler()
        }
    }
    
    func deleteWhere(project: Project) {
        models = models.filter({ $0.project_id != project.id })
    }
    
    static let instance = WorkhourRepository()
}
