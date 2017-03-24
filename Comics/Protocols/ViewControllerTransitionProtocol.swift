//
//  ViewControllerTransitionProtocol.swift
//  Comics
//
//  Created by Alex Zbirnik on 23.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

protocol ViewControllerTransitionProtocol {
    
    func add(asChildViewController viewController: UIViewController, completion: @escaping () -> ())
    func remove(asChildViewController viewController: UIViewController)
    func replace(asChildViewController viewController: UIViewController, to anotherViewController: UIViewController)
}

extension ViewControllerTransitionProtocol where Self: UIViewController {
    
    func add(asChildViewController viewController: UIViewController, completion: @escaping () -> ()) {
        
        self.addChildViewController(viewController)
        
        viewController.view.alpha = 0.0
        self.view.addSubview(viewController.view)
        viewController.view.frame = self.view.bounds
        
        viewController.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.2, delay: 0.3,
                       options: UIViewAnimationOptions.curveLinear, animations: {
            
                        viewController.view.alpha = 1.0
                        
        }) { (finish) in
            
            completion()
        }
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    func replace(asChildViewController viewController: UIViewController, to anotherViewController: UIViewController) {
        
        self.add(asChildViewController: anotherViewController) {
            
            self.remove(asChildViewController: viewController)
        }
    }
    
}
