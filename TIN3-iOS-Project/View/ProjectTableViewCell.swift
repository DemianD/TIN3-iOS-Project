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
    var statuses = [
        Status.Ok: UIColor.init(red: 76/255, green: 217/255, blue: 100/255, alpha: 1),
        .SslExpired: UIColor.init(red: 255/255, green: 149/255, blue: 0/255, alpha: 1),
        .Unreachable: UIColor.init(red: 256/255, green: 59/255, blue: 48/255, alpha: 1)
    ]
    
    @IBOutlet weak var statusIcon: Circle!
    @IBOutlet weak var statusMessage: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    var project: Project? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        title.text = project?.name
        
        if let message = project?.statusMessage {
            statusMessage.text = message
        }
        
        if let status = project?.status {
            statusIcon.color = statuses[status] ?? UIColor.init(red: 256/255, green: 59/255, blue: 48/255, alpha: 1)
        }
    }
}
