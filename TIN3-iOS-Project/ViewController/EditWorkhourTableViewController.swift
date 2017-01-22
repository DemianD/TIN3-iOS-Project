//
//  EditWorkhourTableViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 21/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit

class EditWorkhourTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var _description: UITextField!
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var stopTime: UILabel!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var stopTimePicker: UIDatePicker!
    
    @IBOutlet weak var projectPicker: UIPickerView!

    var workhour: Workhour!
    
    private var items = [Project]() {
        didSet {
            projectPicker.reloadAllComponents()
            updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProjectRepository.instance.all { projects in
            self.items = projects
        }
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        
        _description.text = workhour.description
        location.text = workhour.location
        
        if let start = workhour.start {
            startDate.text = DateManager.instance.convertToSectionName(start)
            startTime.text = DateManager.instance.convertToTimeMinutes(start)
            
            startDatePicker.date = start
            startTimePicker.date = start
        }
        if let stop = workhour.stop {
            stopTimePicker.date = stop
            stopTime.text = DateManager.instance.convertToTimeMinutes(stop)
        }
        
        let currentWorkhourProjectIndex = items.index(where: { $0.id == workhour.project_id }) ?? 0
        projectPicker.selectRow(currentWorkhourProjectIndex, inComponent: 0, animated: false)
    }
    
    @IBAction func save(_ sender: Any) {
        workhour.description = _description.text
        workhour.location = location.text
        
        workhour.start = startTimePicker.date
        workhour.stop = stopTimePicker.date
        
        // Now we need to update the start and stop date without the time
        // TODO
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
}
