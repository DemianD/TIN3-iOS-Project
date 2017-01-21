//
//  Timer.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 20/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class TimerManager {
    
    static let instance = TimerManager()
    
    private struct keys {
        static let currentWorkhour = "currentWorkhour"
    }
    
    private let storage = UserDefaults.standard
    private let dateManager = DateManager.instance
    
    private var timer : Timer?
    
    private var currentWorkhour : Workhour?
    
    var tabBarItem : UITabBarItem? {
        didSet {
            startTimer()
        }
    }
    
    private init() {
        
    }
    
    func toggle(description: String?, location: String?, project_id: Int) {
        let workhour = firstOrNew()
        
        currentWorkhour = workhour
        
        workhour.description = description
        workhour.location = location
        workhour.project_id = project_id
        
        if workhour.isStarted() {
            stop(workhour)
        } else {
            start(workhour)
        }
    }

    func updateCurrentLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let workhour = fetch()
        
        if let workhour = workhour {
            workhour.latitude = latitude
            workhour.longitude = longitude
            
            saveLocal(workhour)
        }
    }
    
    private func start(_ workhour : Workhour) {
        workhour.start = Date()
        
        saveLocal(workhour)
        startTimer()
    }
    
    func started() -> Bool {
        return fetch() != nil
    }
    
    private func stop(_ workhour : Workhour) {
        workhour.stop = Date()
        
        save(workhour)
        stopTimer()
    }
    
    private func firstOrNew() -> Workhour {
        if let currentWorkhour = fetch() {
            return currentWorkhour
        }
        
        return Workhour()
    }
    
    func fetch() -> Workhour? {
        if let currentWorkhour = storage.string(forKey: keys.currentWorkhour) {
            return Workhour(JSONString: currentWorkhour)
        }
        return nil
    }
    
    private func save(_ workhour: Workhour) {
        self.empty()
        WorkhourRepository.instance.save(workhour) { _ in }
    }
    
    private func saveLocal(_ workhour: Workhour) -> Void {
        storage.set(workhour.toJSONString(), forKey: keys.currentWorkhour)
    }
    
    private func empty() {
        storage.removeObject(forKey: keys.currentWorkhour)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { Timer in
            self.fired()
        })
    }
    
    private func stopTimer() {
        if let timer = self.timer {
            timer.invalidate()
            
            tabBarItem?.badgeValue = nil
        }
    }
    
    private func fired() {
        if currentWorkhour == nil {
            currentWorkhour = fetch()
            
            if currentWorkhour == nil {
                return stopTimer()
            }
        }

        if let start = currentWorkhour?.start {
            let elapsed = Date().timeIntervalSince(start)
            
            tabBarItem?.badgeValue = DateManager.instance.convertTimeInterval(elapsed)
        }
    }
}
