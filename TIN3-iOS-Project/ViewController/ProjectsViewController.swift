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
    }
    
    var projects = Array<Project>() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let project1 = Project("TestProject 1")
        
        project1.status = Status.Ok
        
        let project2 = Project("TestProject 2")
        
        project2.status = Status.SslExpired
        
        let project3 = Project("TestProject 3")
        
        project3.status = Status.Unreachable
        
        projects.append(project1);
        projects.append(project2);
        projects.append(project3);
        
        tableView.reloadData()
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
}
