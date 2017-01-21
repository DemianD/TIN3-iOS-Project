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

// Source: https://newfivefour.com/swift-ios-uipicker.html

class EditWorkhourViewController: UITableViewController/*, UIPickerViewDelegate, UIPickerViewDataSource*/ {
    
    var workhour : Workhour!
    
    private var items = [Project]() {
        didSet {
            //projectPicker.reloadAllComponents()
        }
    }
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        ProjectRepository.instance.all {
            self.items = $0
        }
    }
    
    func updateUI() {
        lblDescription.text = workhour!.description
        lblDate.text = DateManager.instance.convertTo(format: "EEEE d MMM yyyy", date: workhour!.start)
        lblTime.text = "van \(workhour!.getStartTime()) tot \(workhour!.getStopTime())"
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = workhour.coordinate
        
        map.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.035, 0.035)
        let region = MKCoordinateRegion(center: workhour.coordinate, span: span)
        

        map.setRegion(region, animated: false)
    }
    
    /*
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
     */
}
