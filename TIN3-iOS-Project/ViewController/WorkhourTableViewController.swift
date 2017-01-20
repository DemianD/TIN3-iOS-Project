//
//  WorkhourTableViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 18/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit

class WorkhourTableViewController: UITableViewController {

    private struct Storyboard {
        static let WorkhourCellIdentifier = "Workhour"
    }
    
    private var section = [String]()
    private var items = [[Workhour]]()
    
    override func viewWillAppear(_ animated: Bool) {
        fetch()
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.addTarget(self, action: #selector(self.fetch), for: .valueChanged)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.WorkhourCellIdentifier, for: indexPath)

        let workhour = items[indexPath.section][indexPath.row]
        
        if let workhourCell = cell as? WorkhourTableViewCell {
            workhourCell.workhour = workhour
        }
        
        return cell
    }
    
    func fetch() {
        WorkhourRepository.instance.all(withRefresh: true) {
            self.section = [String]()
            self.items = [[Workhour]]()
            
            for workhour in $0 {
                if let start = workhour.start {
                    // Eerst een sectie maken, en als die niet bestaat toevoegen
                    let startDate = DateManager.instance.convertToSectionName(start)
                    
                    if !self.section.contains(startDate) {
                        self.section.append(startDate)
                    }
                    
                    // De sectie opvragen
                    let index = self.section.index(of: startDate)!
                    
                    if(self.items.count > index) {
                        self.items[index].append(workhour)
                    } else {
                        self.items.append([workhour])
                    }
                }
            }
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
}
