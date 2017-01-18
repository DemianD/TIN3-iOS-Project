//
//  ProjectViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 27/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import UIKit

class ProjectViewController: UITableViewController {

    private struct Storyboard {
        static let ProjectTimerSegue = "ProjectTimerSegue"
    }
    
    @IBOutlet weak var url: UILabel!
    
    var project: Project?
    
    override func viewDidLoad() {
        updateUI()
    }
    
    private func updateUI() {
        if let project = self.project {
            self.title = project.name
            
            url.text = project.url
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Storyboard.ProjectTimerSegue) {
            if let tvc = segue.destination as? TimerViewController {
                tvc.project = project
            }
        }
    }

}
