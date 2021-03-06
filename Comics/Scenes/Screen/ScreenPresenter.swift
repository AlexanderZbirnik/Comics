//
//  ScreenPresenter.swift
//  Comics
//
//  Created by Alex Zbirnik on 25.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ScreenPresenterInput {
    
    func presentSomething(response: Screen.Something.Response)
}

protocol ScreenPresenterOutput: class {
    
    func displaySomething(viewModel: Screen.Something.ViewModel)
}

class ScreenPresenter: ScreenPresenterInput {
    
    weak var output: ScreenPresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentSomething(response: Screen.Something.Response) {
        
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        
        let viewModel = Screen.Something.ViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
