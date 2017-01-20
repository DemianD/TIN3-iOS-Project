//
//  WorkhourTableViewCell.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 18/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit

class WorkhourTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var stopTime: UILabel!
    
    @IBOutlet weak var _description: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var horizontalLine: UIView!
    
    var workhour: Workhour! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        _description.text = workhour.description
        location.text = workhour.location
        
        startTime.text = workhour.getStartTime()
        stopTime.text = workhour.getStopTime()
        
        if let project = workhour.project {
            horizontalLine.backgroundColor = project.color
        } else {
            horizontalLine.backgroundColor = Colors.standard
        }
    }
}
