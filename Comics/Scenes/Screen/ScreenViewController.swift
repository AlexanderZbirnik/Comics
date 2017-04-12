//
//  ScreenViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 25.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ScreenViewControllerInput {
    func displaySomething(viewModel: Screen.Something.ViewModel)
}

protocol ScreenViewControllerOutput {
    
    func doSomething(request: Screen.Something.Request)
}

class ScreenViewController: UIViewController, ViewControllerTransitionProtocol, ScreenViewControllerInput {
    
    var output: ScreenViewControllerOutput!
    var router: ScreenRouter!
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ScreenConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaultControllerOnLoad()
        self.addNotification()
    }
    
    deinit{
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Event handling
    
    func defaultControllerOnLoad() {
        
        self.router.addDefaultViewController()
    }
    
    // MARK: - Display logic
    
    func displaySomething(viewModel: Screen.Something.ViewModel) {
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
        
        let item = notification.object as! MenuItem
        self.router.addSelectedViewControlerWith(selectedItem: item)
    }
}