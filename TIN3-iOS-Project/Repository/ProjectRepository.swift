//
//  ProjectRepository.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 17/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

// Source for escape and why: http://stackoverflow.com/questions/38990882/closure-use-of-non-escaping-parameter-may-allow-it-to-escape
import Foundation
import Alamofire
import AlamofireObjectMapper

class ProjectRepository {

    var projects = [Project]()
    
    private init() {}
    
    func all(completionHandler: @escaping ([Project]) -> Void) {
        if(projects.isEmpty) {
            fetch() {
                self.projects = $0
                completionHandler($0)
            }
        } else {
            completionHandler(projects)
        }
    }
    
    func find(_ id: Int) -> Project? {
        return projects.first(where: { $0.id == id })
    }
    
    func fetch(completionHandler: @escaping ([Project]) -> Void) {
        Alamofire.request("https://www.demian.io/api/projects").responseArray(keyPath: "data") { (response: DataResponse<[Project]>) -> Void in
            if let projectArray = response.result.value {
                completionHandler(projectArray);
            }
        }
    }
    
    func save(_ project: Project, completionHandler: @escaping (Project) -> Void) {
        Alamofire.request("https://www.demian.io/api/projects", method: .post, parameters: project.toJSON(), encoding: JSONEncoding.default).responseObject(keyPath: "data") { (response: DataResponse<Project>) -> Void in
            
            if let newProject = response.result.value {
                if(project.id == -1) {
                    self.projects.append(newProject)
                }
                completionHandler(newProject)
            }
        }
    }
    
    static let instance = ProjectRepository()
}
