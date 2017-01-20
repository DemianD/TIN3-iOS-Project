//
//  EditWorkhourViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 19/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//
import Foundation
import UIKit
import MapKit
import Eureka

// Source: https://newfivefour.com/swift-ios-uipicker.html

class EditWorkhourViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var items = [Project]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProjectRepository.instance.all {
            self.items = $0
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           titleForRow row: Int,
                           forComponent component: Int) -> String? {
        return items[row].name
    }
}
