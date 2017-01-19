//
//  ProjectColorCollectionViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 19/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProjectColorCollectionViewController: UICollectionViewController {

    var project : Project!
    
    var colors = [
        "Red": UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0),
        "Orange": UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0),
        "Yellow": UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0),
        "Green": UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0),
        "TealBlue": UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1.0),
        "Blue": UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0),
        "Purple": UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1.0),
        "Pink": UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1.0),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.backgroundColor = Array(colors.values)[indexPath.item]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        project.colorName = Array(colors.keys)[indexPath.item]
        
        performSegue(withIdentifier: "unwindFromProjectColor", sender: self)
        
        return true
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
