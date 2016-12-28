//
//  ProjectViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 27/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {

    var project: Project? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let project = self.project {
            self.title = project.name
        
        }
    }

}
