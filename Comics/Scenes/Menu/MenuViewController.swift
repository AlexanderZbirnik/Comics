//
//  MenuViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 25.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

extension Notification.Name {
    
    static let menuSelectedItemNotificationName = Notification.Name("menuSelectedItemNotificationName")
    static let menuOpenOrCloseNotificationName  = Notification.Name("menuOpenOrCloseNotificationName")
}

protocol MenuViewControllerInput {
    
    func displayItems(viewModel: Menu.Items.ViewModel)
}

protocol MenuViewControllerOutput {
    
    func fetchItems(request: Menu.Items.Request)
}

class MenuViewController: UIViewController, MenuViewControllerInput {
    
    var output: MenuViewControllerOutput!
    var router: MenuRouter!
    var displayedItems: [Menu.Items.ViewModel.DisplayItem] = []
    var lastSelectedRow = MenuItem.stuffList.hashValue
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        MenuConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchItemsOnLoad()
    }
    
    // MARK: - Event handling
    
    func fetchItemsOnLoad() {
        
        let request = Menu.Items.Request()
        self.output.fetchItems(request: request)
    }
    
    // MARK: - Display logic
    
    func displayItems(viewModel: Menu.Items.ViewModel) {
        
        self.displayedItems = viewModel.displayedItems
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.displayedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as UITableViewCell!
        
        let item = self.displayedItems[indexPath.row]
        cell.textLabel?.text = item.title
        
        let icon = UIImage(named: item.iconName)
        cell.imageView?.image = icon
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.lastSelectedRow != indexPath.row || self.lastSelectedRow == MenuItem.stuffList.hashValue {
            
            self.lastSelectedRow = indexPath.row
            
            let items = [MenuItem.aboutUs, MenuItem.stuffList, MenuItem.settings]
            let item = items[indexPath.row]
            
            NotificationCenter.default.post(name: .menuSelectedItemNotificationName, object: item)
        }
    }
}













