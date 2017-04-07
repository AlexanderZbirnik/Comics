//
//  StuffCell.swift
//  Comics
//
//  Created by Alex Zbirnik on 23.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class StuffCell: UITableViewCell, ReuseIdentifierProtocol {
    
    @IBOutlet weak var stuffImageView: UIImageView!
    
    @IBOutlet weak var stuffNameLabel: UILabel!
    @IBOutlet weak var stuffDateLabel: UILabel!
}
