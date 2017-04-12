//
//  ListConfigurator.swift
//  Comics
//
//  Created by Alex Zbirnik on 26.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension ListViewController: ListPresenterOutput{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        router.passDataToNextScene(segue: segue)
    }
}

extension ListInteractor: ListViewControllerOutput {
}

extension ListPresenter: ListInteractorOutput {
}

class ListConfigurator {
    
    // MARK: - Object lifecycle
    
    static let sharedInstance = ListConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: ListViewController) {
        
        let router = ListRouter()
        router.viewController = viewController
        
        let presenter = ListPresenter()
        presenter.output = viewController
        
        let interactor = ListInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
