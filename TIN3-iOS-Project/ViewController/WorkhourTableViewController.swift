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
        WorkhourRepository.instance.all(withRefresh: true) {
            self.sections = [String]()
            self.items = [[Workhour]]()
            
            for workhour in $0 {
                if let start = workhour.start {
                    // Eerst een sectie maken, en als die niet bestaat toevoegen
                    let startDate = DateManager.instance.convertToSectionName(start)
                    
                    if !self.sections.contains(startDate) {
                        self.sections.append(startDate)
                    }
                    
                    // De sectie opvragen
                    let index = self.sections.index(of: startDate)!
                    
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
