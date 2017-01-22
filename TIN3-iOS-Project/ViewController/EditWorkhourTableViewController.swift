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
    
    private var pickers = [(section : Int, row: Int, collapsed: Bool, picker: UIDatePicker, label: UILabel)]()

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
        
        initPickers()
        
        updateUI()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (index, tupple) in pickers.enumerated() {
            
            if(tupple.section == indexPath.section && tupple.row == indexPath.row && tupple.collapsed == false) {
                pickers[index].collapsed = true
                pickers[index].picker.isHidden = false
            } else {
                pickers[index].collapsed = false
                pickers[index].picker.isHidden = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tupple = pickers.first(where: {
            $0.section == indexPath.section &&
            $0.row == (indexPath.row - 1) && // opgelet voor de -1
            $0.collapsed == false
        })
        
        if tupple != nil {
            return 0 // de hoogte 0 maken
        }

        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func togglePicker() {
        
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
        
        workhour.project_id = items[projectPicker.selectedRow(inComponent: 0)].id
        
        workhour.start = startTimePicker.date
        workhour.stop = stopTimePicker.date
        
        // kan korter, TODO
        workhour.start = DateManager.instance.setOnlyDate(from: startDatePicker.date, to: workhour.start!)
        workhour.stop = DateManager.instance.setOnlyDate(from: startDatePicker.date, to: workhour.stop!)
        
        WorkhourRepository.instance.save(workhour) { _ in
            self.performSegue(withIdentifier: "workhour", sender: self)
        }
        
        // Now we need to update the start and stop date without the time
        // TODO
    }
    
    private func initPickers() {
        startDatePicker.addTarget(self, action: #selector(self.datePickerChanged(sender:)), for: .valueChanged)
        startTimePicker.addTarget(self, action: #selector(self.datePickerChanged(sender:)), for: .valueChanged)
        stopTimePicker.addTarget(self, action: #selector(self.datePickerChanged(sender:)), for: .valueChanged)
        
        pickers = [
            (2, 0, false, startDatePicker, startDate),
            (2, 2, false, startTimePicker, startTime),
            (2, 4, false, stopTimePicker, stopTime)
        ]
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
    
    func datePickerChanged(sender: UIDatePicker) {
        if let tupple = pickers.first(where: { $0.picker == sender }) {
            if tupple.row == 0 {
                tupple.label.text = DateManager.instance.convertToSectionName(tupple.picker.date)
            } else {
                tupple.label.text = DateManager.instance.convertToTimeMinutes(tupple.picker.date)
            }
        }
    }
}
