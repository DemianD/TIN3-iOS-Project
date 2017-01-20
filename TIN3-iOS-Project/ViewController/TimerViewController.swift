//
//  TimerViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 18/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit

class TimerViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var toggle: UIButton!
    
    @IBOutlet weak var _description: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var projectPicker: UIPickerView!
    
    private struct keys {
        static let currentWorkhour = "currentWorkhour"
    }
    
    private var items = [Project]() {
        didSet {
            projectPicker.reloadAllComponents()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProjectRepository.instance.all { projects in
            self.items = projects
            self.updateUI()
        }
        
        super.viewWillAppear(animated)
    }
    
    func updateUI() {
        
        // Indien er een werkuur bezig is, dan gaan we de gegevens opnieuw invullen
        if let currentWorkhour = loadWorkhour() {
            _description.text = currentWorkhour.description
            location.text = currentWorkhour.location
            
            let currentWorkhourProjectIndex = items.index(where: { $0.id == currentWorkhour.project_id }) ?? 0
            projectPicker.selectRow(currentWorkhourProjectIndex, inComponent: 0, animated: false)
            
            toggle.setTitle("Stop", for: .normal)
        } else {
            _description.text = ""
            location.text = ""
            
            toggle.setTitle("Start", for: .normal)
        }
        
        tabBarController?.tabBar.items?.last?.badgeValue = "00:01"
    }

    @IBAction func toggleTimer(_ sender: UIButton) {
        let currentWorkhour = firstOrNew()
        
        if currentWorkhour.isStarted() {
            currentWorkhour.stop = Date()
            save(currentWorkhour)
        } else {
            currentWorkhour.start = Date()
            saveLocal(currentWorkhour)
        }
        
        updateUI()
    }
    
    func firstOrNew() -> Workhour {
        let defaults = UserDefaults.standard
        var workhour = Workhour()
        
        if let currentWorkhour = defaults.string(forKey: keys.currentWorkhour) {
            print(currentWorkhour)
            workhour = Workhour(JSONString: currentWorkhour)!
        }
        
        // Wanneer men start/stopt zullen we alle huidige waardes (beschrijving, locatie, project) overschrijven
        workhour.project_id = items[projectPicker.selectedRow(inComponent: 0)].id
        workhour.description = _description.text
        workhour.location = location.text

        return workhour
    }
    
    func loadWorkhour() -> Workhour? {
        let defaults = UserDefaults.standard

        if let currentWorkhour = defaults.string(forKey: keys.currentWorkhour) {
            return Workhour(JSONString: currentWorkhour)
        }
        return nil
    }
    
    func save(_ workhour: Workhour) -> Void {
        print(workhour.toJSON())
        
        WorkhourRepository.instance.save(workhour) { _ in
            self.empty()
        }
    }
    
    func saveLocal(_ workhour: Workhour) -> Void {
        UserDefaults.standard.set(workhour.toJSONString(), forKey: keys.currentWorkhour)
    }
    
    func empty() {
        UserDefaults.standard.removeObject(forKey: keys.currentWorkhour)
        
        updateUI()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].name
    }
    
    // Source: gezien tijdens de les
    @IBAction func hideKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
