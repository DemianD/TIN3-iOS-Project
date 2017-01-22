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

class WorkhourViewController: UITableViewController {
    
    private struct Storyboard {
        static let EditWorkhourSegue = "EditWorkhourSegue"
    }
    
    var workhour : Workhour!
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        lblDescription.text = workhour.description == "" ? "Geen omschrijving" : workhour.description
        lblDate.text = DateManager.instance.convertTo(format: "EEEE d MMM yyyy", date: workhour!.start)
        lblTime.text = "van \(workhour.getStartTime()) tot \(workhour.getStopTime())"
        
        // Create an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = workhour.coordinate
        
        map.addAnnotation(annotation)
        
        // Set the zoom and the region
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: workhour.coordinate, span: span)

        map.setRegion(region, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Storyboard.EditWorkhourSegue) {
            if let pcv = segue.destination as? EditWorkhourTableViewController {
                pcv.workhour = workhour
            }
        }
    }
    
    @IBAction func unwindToWorkhour(segue: UIStoryboardSegue) {
        updateUI()
    }
}
