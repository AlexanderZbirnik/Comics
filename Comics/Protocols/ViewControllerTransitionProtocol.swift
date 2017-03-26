//
//  ViewControllerTransitionProtocol.swift
//  Comics
//
//  Created by Alex Zbirnik on 23.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

protocol ViewControllerTransitionProtocol {
    
    func add(asChildViewController viewController: UIViewController, animated: Bool, completion: @escaping () -> ())
    func remove(asChildViewController viewController: UIViewController)
    func replace(asChildViewController viewController: UIViewController, to anotherViewController: UIViewController)
}

extension ViewControllerTransitionProtocol where Self: UIViewController {
    
    
    func add(asChildViewController viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
        
        self.addChildViewController(viewController)
        
        self.view.addSubview(viewController.view)
        viewController.view.frame = self.view.bounds
        
        viewController.didMove(toParentViewController: self)
        
        if animated == true {
            
            viewController.view.alpha = 0.0
            
            UIView.animate(withDuration: 0.2, delay: 0.3,
                           options: UIViewAnimationOptions.curveLinear, animations: {
                            
                            viewController.view.alpha = 1.0
                            
            }) { (finish) in
                
                completion()
            }
            
        } else {
            
             completion()
        }
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    func replace(asChildViewController viewController: UIViewController, to anotherViewController: UIViewController) {
        
        self.add(asChildViewController: anotherViewController, animated: true) {
            
            self.remove(asChildViewController: viewController)
        }
    }
    
}
