//
//  ListPresenter.swift
//  Comics
//
//  Created by Alex Zbirnik on 26.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

extension Date{
    
    func formattedDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMMM-YYYY HH:mm"
        
        let date = dateFormatter.string(from: self)
        
        return date
    }
}

protocol ListPresenterInput {
    
    func presentStuffList(response: List.Stuff.Response)
}

protocol ListPresenterOutput: class {
    
    func displayStuffList(viewModel: List.Stuff.ViewModel)
}

class ListPresenter: ListPresenterInput {
    
    weak var output: ListPresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentStuffList(response: List.Stuff.Response) {
        
        let placeholderName = response.placeholderName
        
        var displayedStuffList: [List.Stuff.ViewModel.DisplayedStuff] = []
        
        for stuff in response.stuffList {
            
            let itemId = stuff.itemId
            let name = stuff.name
            let imageUrl = stuff.imageUrl
            let date = stuff.date.formattedDate()
            
            let displayedStuff =
                List.Stuff.ViewModel.DisplayedStuff(itemId: itemId, name: name, imageUrl: imageUrl, date: date)
            
            displayedStuffList.append(displayedStuff)
        }
        
        let viewModel =
            List.Stuff.ViewModel(displayedStuff: displayedStuffList, placeholderName: placeholderName)
        
        self.output.displayStuffList(viewModel: viewModel)
    }
}
