//
//  ReuseIdentifierProtocol.swift
//  Comics
//
//  Created by Alex Zbirnik on 07.04.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

protocol ReuseIdentifierProtocol {
    
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifierProtocol where Self: Any {
    
    static var reuseIdentifier: String {
        
        return NSStringFromClass(self as! AnyClass).components(separatedBy: ".").last!
    }
}
