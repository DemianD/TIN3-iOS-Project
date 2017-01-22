//
//  ProjectTableViewCell.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 27/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell
{
    @IBOutlet weak var statusIcon: Circle!
    
    @IBOutlet weak var title: UILabel!
    
    var project: Project! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        title.text = project.name
        statusIcon.color = project.color
    }
}
