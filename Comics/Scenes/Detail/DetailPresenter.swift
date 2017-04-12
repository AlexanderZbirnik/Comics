//
//  DetailPresenter.swift
//  Comics
//
//  Created by Alex Zbirnik on 26.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol DetailPresenterInput {
    
    func presentDetail(response: Detail.Stuff.Response)
}

protocol DetailPresenterOutput: class {
    
    func displayDetail(viewModel: Detail.Stuff.ViewModel)
}

class DetailPresenter: DetailPresenterInput {
    
    weak var output: DetailPresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentDetail(response: Detail.Stuff.Response) {
        
        let placeholderName = response.placeholderName
        let detail = response.stuff.description
        let imageUrl = response.stuff.imageUrl
        
        let displayStuff = Detail.Stuff.ViewModel.DisplayStuff(detail: detail, imageUrl: imageUrl)
        
        let viewModel = Detail.Stuff.ViewModel(displayStuff: displayStuff, placeholderName: placeholderName)
        output.displayDetail(viewModel: viewModel)
    }
}