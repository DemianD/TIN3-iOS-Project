//
//  CreateProjectViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 28/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import UIKit
import Eureka

class CreateProjectViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form = Section("Algemeen")
            <<< TextRow(){
                $0.tag = "name"
                $0.title = "Naam"
                $0.placeholder = "Projectnaam"
            }
            <<< URLRow(){
                $0.tag = "url"
                $0.title = "Website"
                $0.placeholder = "http://example.com"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        
        let valuesDictionary = form.values()
        
        let project = Project();
        
        if let name = valuesDictionary["name"] as? String {
            project.name = name;
        }
        
        if let url =  (valuesDictionary["url"] as? NSURL)?.absoluteString {
            project.url = url
        }
        
        ProjectRepository.instance.save(project) { project in
            sender.isEnabled = true
            
            self.performSegue(withIdentifier: "projects", sender: self)
        };
    }
}
