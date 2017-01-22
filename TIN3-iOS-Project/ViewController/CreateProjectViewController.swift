//
//  CreateProjectViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 28/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import UIKit

class CreateProjectViewController: UITableViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var website: UITextField!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        
        let project = Project();
        
        project.name = name.text
        project.url = website.text
        
        ProjectRepository.instance.save(project) { project in
            sender.isEnabled = true
            
            self.performSegue(withIdentifier: "projects", sender: self)
        };
    }
    
    @IBAction func hideKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
