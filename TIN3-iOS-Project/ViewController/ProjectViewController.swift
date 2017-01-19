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
        static let EditProjectSegue = "EditProjectSegue"
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var pricePerHour: UILabel!
    @IBOutlet weak var colorName: UILabel!
    
    var project: Project?
    
    override func viewDidLoad() {
        updateUI()
    }
    
    private func updateUI() {
        if let project = self.project {
            self.title = project.name
            
            name.text = project.name
            url.text = project.url
            pricePerHour.text = String(project.pricePerHour)
            colorName.text = project.colorName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Storyboard.ProjectTimerSegue) {
            if let tvc = segue.destination as? TimerViewController {
                tvc.project = project
            }
        }
        else if(segue.identifier == Storyboard.EditProjectSegue) {
            if let epc = segue.destination as? EditProjectTableViewController {
                epc.project = project
            }
        }
    }
    
    @IBAction func unwindToProject(segue: UIStoryboardSegue) {
        updateUI()
    }
}
