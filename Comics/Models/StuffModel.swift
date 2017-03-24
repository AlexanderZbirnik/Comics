//
//  StuffModel.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class StuffModel {
    
    var itemId: String?
    var name: String?
    var imageUrl: String?
    var description: String?
    var date: Date?
    
    init(with dict: Dictionary<String, Any>) {
        
        self.itemId = dict["itemId"] as? String
        self.name = dict["name"] as? String
        self.imageUrl = dict["image"] as? String
        self.description = dict["description"] as? String

        if  let posixDateString = (dict["time"] as? String) {

            self.date = dateFrom(posixDate: posixDateString)
        }
    }
    
    func dateFrom(posixDate: String) ->(Date) {
        
        let posixDateValue = Double(posixDate)
        let timeInterval = TimeInterval(posixDateValue!) / 1000
        
        return Date(timeIntervalSince1970:  timeInterval)
    }
}
