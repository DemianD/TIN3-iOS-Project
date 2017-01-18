//
//  TimerViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 18/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit

// Source: http://stackoverflow.com/questions/28628225/how-do-you-save-local-storage-data-in-a-swift-application
// Source: http://stackoverflow.com/questions/31203241/how-to-use-nsuserdefaults-in-swift

class TimerViewController: UIViewController
{
    struct keys {
        static let currentWorkhour = "currentWorkhour"
    }
    
    var project: Project!
    
    @IBAction func toggleTimer(_ sender: UIButton) {
        let currentWorkhour = firstOrNew()
        
        if currentWorkhour.isStarted() {
            currentWorkhour.stop = Date()
            sender.setTitle("start", for: .normal)
            
            save(currentWorkhour)
            
        } else {
            currentWorkhour.start = Date()
            sender.setTitle("stop", for: .normal)
            
            saveLocal(currentWorkhour)
        }
    }
    
    func firstOrNew() -> Workhour {
        let defaults = UserDefaults.standard
        
        if let currentWorkhour = defaults.string(forKey: keys.currentWorkhour) {
            return Workhour(JSONString: currentWorkhour)!
        }
        
        let workhour = Workhour()
        workhour.project_id = project.id
        
        return workhour
    }
    
    func save(_ workhour: Workhour) -> Void {
        
        WorkhourRepository.instance.save(workhour) {
            print($0.toJSONString())
            self.empty()
        }
    }
    
    func saveLocal(_ workhour: Workhour) -> Void {
        UserDefaults.standard.set(workhour.toJSONString(), forKey: keys.currentWorkhour)
    }
    
    func empty() {
        UserDefaults.standard.removeObject(forKey: keys.currentWorkhour)
    }
}
