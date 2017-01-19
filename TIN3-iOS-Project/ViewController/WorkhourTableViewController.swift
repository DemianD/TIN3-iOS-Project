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
    
    var section = [String]()
    var items = [[Workhour]]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let format = DateFormatter()
        format.dateFormat = "E dd MMM"
        
        WorkhourRepository.instance.all() {
            for workhour in $0 {
                if let start = workhour.start {
                    let startDate = format.string(from: start)
                    
                    if !self.section.contains(startDate) {
                        self.section.append(startDate)
                    }
                    
                    let index = self.section.index(of: startDate)!
                    
                    if(self.items.count > index) {
                        self.items[index].append(workhour)
                    } else {
                        self.items.append([workhour])
                    }
                }
            }
            
            self.tableView.reloadData()
        }
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        let item = items[indexPath.section][indexPath.row]
        
        if let workhourCell = cell as? WorkhourTableViewCell {
            workhourCell.startTime.text = item.getStartTime()
            workhourCell.stopTime.text = item.getStopTime()
            workhourCell._description.text = item.description
            workhourCell.location.text = item.location
        }
        
        return cell
    }
}
