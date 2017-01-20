//
//  MenuViewController.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 20/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//

import UIKit

class MenuViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        TimerManager.instance.tabBarItem = tabBar.items?[1]
    }
}
