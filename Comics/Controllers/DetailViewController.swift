//
//  DetailViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ReuseIdentifierProtocol {
    
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    var stuff: StuffModel?
    
    //MARK: -  Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.downloadImage(url: (self.stuff?.imageUrl!)!, placeholder: UIImage(named: ImageNames.placeholder.rawValue)!, activityIndicatorLarge: true)
        self.detailLabel.text = self.stuff?.description
    }
    
    func add(stuff :StuffModel) {
        
        self.stuff = stuff
    }
}
