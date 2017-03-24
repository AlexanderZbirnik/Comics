//
//  MainViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var screenContainerView: UIView!
    @IBOutlet weak var screenContainerViewLeftConstraint: NSLayoutConstraint!
    
    var openMenu = false
    
    //MARK: -  Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = MenuItem.stuffList.rawValue
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            
            menuButton.isHidden = true;
        }
        
        self.addNotification()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Menu methods
    
    func menu(open: Bool)  {
        
        var leftConstraint: CGFloat = CGFloat.leastNormalMagnitude
        
        if open {
            
            leftConstraint = self.menuContainerView.bounds.size.width
        }
        
        UIView.animate(withDuration: 0.3) { 
            
            self.screenContainerViewLeftConstraint.constant = leftConstraint
            
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func menuButtonAction(_ sender: Any) {
        
        self.openMenu = !self.openMenu
        self.menu(open: self.openMenu)
        
        NotificationCenter.default.post(name: .menuOpenOrCloseNotificationName, object: NSNumber(value: self.openMenu))
    }
    
    //MARK: - Notification
    
    func addNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MainViewController.menuSelectedItem(notification:)),
                                               name: NSNotification.Name.menuSelectedItemNotificationName,
                                               object: nil)
        
    }
    
    
    func menuSelectedItem(notification: Notification) {
        
        let item = notification.object as! MenuItem
        self.navigationItem.title = item.rawValue
        
        self.openMenu = false
        self.menu(open: self.openMenu)
        
        NotificationCenter.default.post(name: .menuOpenOrCloseNotificationName, object: NSNumber(value: self.openMenu))
        
    }
}
