//
//  MenuViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

enum MenuItem: String {
    
    case aboutUs = "About us"
    case stuffList = "Stuff list"
    case settings = "Settings"
}

enum MenuIcon: String {
    
    case aboutus = "aboutus"
    case list = "list"
    case settings = "settings"
}

extension Notification.Name {
    
    static let menuSelectedItemNotificationName = Notification.Name("menuSelectedItemNotificationName")
    static let menuOpenOrCloseNotificationName  = Notification.Name("menuOpenOrCloseNotificationName")
}

class MenuViewController: UIViewController {
    
    let menuItems = [MenuItem.aboutUs, MenuItem.stuffList, MenuItem.settings]
    let menuIcons = [MenuIcon.aboutus, MenuIcon.list, MenuIcon.settings]
    
    var lastSelectedRow = MenuItem.stuffList.hashValue
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as UITableViewCell!
        
        let item = self.menuItems[indexPath.row]
        cell.textLabel?.text = item.rawValue
        
        let icon = UIImage(named: self.menuIcons[indexPath.row].rawValue)
        cell.imageView?.image = icon
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        if self.lastSelectedRow != indexPath.row || self.lastSelectedRow == MenuItem.stuffList.hashValue{
            
            self.lastSelectedRow = indexPath.row
            let item = self.menuItems[indexPath.row]
            
            NotificationCenter.default.post(name: .menuSelectedItemNotificationName, object: item)
        }
    }
}
