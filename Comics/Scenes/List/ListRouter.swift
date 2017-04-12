//
//  ListRouter.swift
//  Comics
//
//  Created by Alex Zbirnik on 26.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ListRouterInput{
    
    func navigateToDetailViewController()
}

class ListRouter: ListRouterInput {
    
    weak var viewController: ListViewController!
    
    // MARK: - Navigation
    
    func navigationToDetailsWithSelected(index: Int, completion: @escaping () -> ()) {
        
        if self.viewController.displayedStuffList.count == 1 {
            
            self.navigateToDetailViewController()
            
        } else {
            
            self.navigateToPagesViewControllerWithSelected(index: index, completion: { 
                
                completion()
            })
        }
    }
    
    func navigateToDetailViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailViewController =
            storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let displayedStuff = self.viewController.displayedStuffList.first
        let stuff = ListWorker.stuffWith(itemId: (displayedStuff?.itemId)!, from: self.viewController.output.list!)

        detailViewController.output.stuff = stuff

        self.viewController.add(asChildViewController: detailViewController, animated: true) {}
    }
    
    func navigateToPagesViewControllerWithSelected(index: Int, completion: @escaping () -> ()) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pagesViewController =
            storyboard.instantiateViewController(withIdentifier: "PagesViewController") as! PagesViewController

        pagesViewController.output.list = self.viewController.output.list
        pagesViewController.selectedIndex = index
        self.viewController.add(asChildViewController: pagesViewController, animated: true) {
        
            completion()
        }
    }
    
    // MARK: - Communication
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
        if segue.identifier == "ShowSomewhereScene" {
            passDataToSomewhereScene(segue: segue)
        }
    }
    
    func passDataToSomewhereScene(segue: UIStoryboardSegue) {
        
        // NOTE: Teach the router how to pass data to the next scene
        
        // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
        // someWhereViewController.output.name = viewController.output.name
    }
}
