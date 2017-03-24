//
//  SettingsViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: -  Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage(named: "settingsImage")
    }
}
