//
//  TableView.swift
//  Comics
//
//  Created by Alex Zbirnik on 23.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tableFooterView = UIView(frame: CGRect.zero)
    }
}
