//
//  TimerViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 18/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit
import CoreLocation

class TimerViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate
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
    
    private let timer = TimerManager.instance
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Zal wel veel batterij gebruiken
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProjectRepository.instance.all { projects in
            self.items = projects
            self.updateUI()
        }
        
        super.viewWillAppear(animated)
    }
    
    func updateUI() {
        if let currentWorkhour = timer.fetch() {
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
    }

    @IBAction func toggleTimer(_ sender: UIButton) {
        let project_id = items[projectPicker.selectedRow(inComponent: 0)].id

        timer.toggle(description: _description.text, location: location.text, project_id: project_id)
        
        if timer.started() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        updateUI()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(locations.count > 0) {
            timer.updateCurrentLocation(
                latitude: locations.first!.coordinate.latitude,
                longitude: locations.first!.coordinate.longitude)
            
            locationManager.stopUpdatingLocation()
        }
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
    
    @IBAction func hideKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
