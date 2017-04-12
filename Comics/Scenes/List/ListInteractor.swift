//
//  ListInteractor.swift
//  Comics
//
//  Created by Alex Zbirnik on 26.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

enum URLS: String {
    
    case information = "http://any-url.com"
}

enum ImageNames: String {
    
    case placeholder = "placeholder"
}

protocol ListInteractorInput {
    
    func fetchStuffList(request: List.Stuff.Request)
    func filteredStuffList(request: List.Stuff.Request)
    func fetchLocalStuffList(request: List.Stuff.Request)
    var list: [StuffModel]? { get set}
}

protocol ListInteractorOutput {
    
    func presentStuffList(response: List.Stuff.Response)
}

class ListInteractor: ListInteractorInput {
    
    var output: ListInteractorOutput!
    var worker: ListWorker!
    
    var list: [StuffModel]?
    
    // MARK: - Business logic
    
    func fetchStuffList(request: List.Stuff.Request) {
        
        worker = ListWorker()
        worker.getStuffListWith(url: URLS.information.rawValue, completion: { (stuffList) in
            
            let placeholderName = ImageNames.placeholder.rawValue
            let stuffList: [StuffModel] = stuffList
            self.list = stuffList
            
            let response = List.Stuff.Response(stuffList: stuffList, placeholderName: placeholderName)
            self.output.presentStuffList(response: response)
            
        }) { (error) in
            
            print(error)
        }
    }
    
    func filteredStuffList(request: List.Stuff.Request) {
        
        let placeholderName = ImageNames.placeholder.rawValue
        let filteredList = self.list?.filter { $0.name == request.searchText }
        let response = List.Stuff.Response(stuffList: filteredList!, placeholderName: placeholderName)
        self.output.presentStuffList(response: response)
    }
    
    func fetchLocalStuffList(request: List.Stuff.Request) {
        
        let placeholderName = ImageNames.placeholder.rawValue
        let response = List.Stuff.Response(stuffList: self.list!, placeholderName: placeholderName)
        self.output.presentStuffList(response: response)
        
    }
}