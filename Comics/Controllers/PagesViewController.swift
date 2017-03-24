//
//  PagesViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 23.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class PagesViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages: [UIViewController] = []
    var list: [StuffModel] = []
    var selectedIndex: Int = 0
    
    //MARK: -  Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.createAndSetPages()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Stuff and Pages methods
    
    func createAndSetPages() {
        
        for stuff in self.list {
            
            let page = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            page.add(stuff: stuff)
            
            self.pages.append(page)
        }
        
        setViewControllers([pages[self.selectedIndex]],
                           direction: UIPageViewControllerNavigationDirection.forward,
                           animated: false, completion: nil)
        
    }
    
    func stuff(list: [StuffModel], selectedIndex: Int) {
        
        self.list = list
        self.selectedIndex = selectedIndex
    }
    
    //MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex =  self.pages.index(of: viewController)!
        let rightIndex = abs((currentIndex + 1) %  self.pages.count)
        
        return self.pages[rightIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let currentIndex =  self.pages.index(of: viewController)!
        
        if currentIndex == 0 {
            
            let leftIndex = self.pages.count - 1
            return self.pages[leftIndex]
            
        } else {
            
            let leftIndex = abs((currentIndex - 1) %  self.pages.count)
            return self.pages[leftIndex]
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return  self.pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
