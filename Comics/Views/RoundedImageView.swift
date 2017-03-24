//
//  RoundedImageView.swift
//  Comics
//
//  Created by Alex Zbirnik on 23.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }

}

