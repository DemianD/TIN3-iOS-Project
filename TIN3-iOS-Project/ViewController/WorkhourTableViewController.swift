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
        static let ShowWorkhourSegue = "ShowWorkhourSegue"
    }
    
    var project : Project?
    
    private var sections = [String]()
    private var items = [[Workhour]]()
    
    private var documentController : UIDocumentInteractionController!
    
    override func viewWillAppear(_ animated: Bool) {
        fetch()
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.addTarget(self, action: #selector(self.fetch), for: .valueChanged)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
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
    
    @IBAction func export(_ sender: UIBarButtonItem) {
        var content = ""
        
        for (i, _) in sections.enumerated() {
            for workhour in items[i] {
                content.append(workhour.csvRow())
            }
        }
        
        let url = NSTemporaryDirectory().appending("test.csv")
        
        do {
            try content.write(toFile: url, atomically: true, encoding: String.Encoding.utf8)
            
            documentController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: url))
            documentController.presentOptionsMenu(from: sender.accessibilityFrame, in: self.view, animated: true)
        } catch {
            // TODO : notification
        }
    }
    
    
    func fetch() {
        if let project = self.project {
            WorkhourRepository.instance.all(project: project, withRefresh: true) {
                self.fillDateWithSectionsAndRows(workhours: $0)
            }
        } else {
            WorkhourRepository.instance.all(withRefresh: true) {
                self.fillDateWithSectionsAndRows(workhours: $0)
            }
        }
    }
    
    func fillDateWithSectionsAndRows(workhours: [Workhour]) {
        sections = [String]()
        items = [[Workhour]]()
        
        for workhour in workhours {
            if let start = workhour.start {
                // Eerst een sectie maken, en als die niet bestaat toevoegen
                let startDate = DateManager.instance.convertToSectionName(start)
                
                if !sections.contains(startDate) {
                    sections.append(startDate)
                }
                
                // De sectie opvragen
                let index = sections.index(of: startDate)!
                
                if(items.count > index) {
                    items[index].append(workhour)
                } else {
                    items.append([workhour])
                }
            }
        }
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
        scrollToToday()
    }
    
    func scrollToToday() {
        let sectionNameToday = DateManager.instance.convertToSectionName(Date())
        var bestSectionIndex = -1
        
        for (index, element) in sections.enumerated() {
            bestSectionIndex = index
            
            if sectionNameToday == element {
                break;
            }
        }
        
        if bestSectionIndex != -1 {
            tableView.scrollToRow(
                at: IndexPath(row: 0, section: bestSectionIndex),
                at: UITableViewScrollPosition.top, animated: false)
        }
    }
}
