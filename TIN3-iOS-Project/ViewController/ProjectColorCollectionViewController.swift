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
    
    var colors = Colors.dictionary
    
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
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        project.colorName = Array(colors.keys)[indexPath.item]
        
        performSegue(withIdentifier: "unwindFromProjectColor", sender: self)
        
        return true
    }
}
