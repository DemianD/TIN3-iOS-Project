//
//  EditProjectTableViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 19/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit

class EditProjectTableViewController: UITableViewController {
    
    private struct Storyboard {
        static let ProjectColorSegue = "ProjectColorSegue"
    }

    var project: Project!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var pricePerHour: UITextField!
    @IBOutlet weak var colorName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        name.text = project.name
        website.text = project.url
        pricePerHour.text = String(project.pricePerHour)
        colorName.text = project.colorName
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        project.name = name.text
        project.url = website.text
        project.pricePerHour = Double(pricePerHour.text ?? "") ?? 0
        
        ProjectRepository.instance.save(project) {
            self.project = $0
            self.performSegue(withIdentifier: "unwindToProject", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Storyboard.ProjectColorSegue) {
            if let pcv = segue.destination as? ProjectColorCollectionViewController {
                pcv.project = project
            }
        }
    }
    
    @IBAction func unwindFromProjectColor(segue: UIStoryboardSegue) {
        // Only update the color name
        colorName.text = project.colorName
    }
}
