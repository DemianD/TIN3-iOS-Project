//
//  ProjectsViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 27/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController
{
    private struct Storyboard {
        static let ProjectCellIdentifier = "Project"
        static let ShowProjectSegue = "ShowProjectSegue"
        static let CreateProjectSegue = "CreateProjectSegue"
    }
    
    var projects = Array<Project>() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        projects.removeAll();
        
        ProjectRepository.instance.all { result in
            self.projects = result
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    // Get the template cell, we are using a struct for the identifier because it's cleaner.
    // Seen in Stanford University iOS videos
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ProjectCellIdentifier, for: indexPath)
        
        let project = projects[indexPath.row]

        if let projectCell = cell as? ProjectTableViewCell {
            projectCell.project = project
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Storyboard.ShowProjectSegue) {
            if let pvc = segue.destination as? ProjectViewController {
                pvc.project = projects[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    @IBAction func unwindToProjects(segue: UIStoryboardSegue) {
        
    }
}
