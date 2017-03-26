//
//  ScreenViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController, ViewControllerTransitionProtocol {
    
    //MARK: -  Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        let listViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "ListViewController")
        
        self.add(asChildViewController: listViewController!, animated: false) {}
        self.addNotification()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Transition methods
    
    func open(controller: UIViewController) {
        
        let contoller = self.childViewControllers.first
        
        self.replace(asChildViewController: contoller!, to: controller)
    }
    
    //MARK: - Notification
    
    func addNotification() {
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ScreenViewController.menuSelectedItem(notification:)),
                                               name: NSNotification.Name.menuSelectedItemNotificationName,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ScreenViewController.menuOpenOrClosed(notification:)),
                                               name: NSNotification.Name.menuOpenOrCloseNotificationName,
                                               object: nil)
    }
    
    func menuOpenOrClosed(notification: Notification) {
        
        let openMenu = notification.object as! NSNumber
        
        self.view.isUserInteractionEnabled = !openMenu.boolValue
    }
    
    func menuSelectedItem(notification: Notification) {
        
        let selectedMenuItem = notification.object as! MenuItem
        
        switch selectedMenuItem {
            
        case MenuItem.aboutUs:
            
            let aboutUsViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController")
            
            self.open(controller: aboutUsViewController!)
            
            break
            
        case MenuItem.stuffList:
            
            let listViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "ListViewController")
            
            self.open(controller: listViewController!)
            
            break
            
        case MenuItem.settings:
            
            let settingsViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController")
            
            self.open(controller: settingsViewController!)
            
            break
            
        }
    }
}
