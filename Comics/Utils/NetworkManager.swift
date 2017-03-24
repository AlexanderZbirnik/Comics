//
//  NetworkManager.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit
import Foundation

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    func getList(with urlString: String, completion: @escaping (Array<Any>) -> (), failure: @escaping (String) -> ()) {
        
        let url:URL = URL(string: urlString)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in

            do {
                
                guard let data = data else {
                    
                    throw JSONError.NoData
                }
                
                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Any> else {
                    
                    throw JSONError.ConversionFailed
                }
                
                completion(jsonArray)
                
            } catch let error as JSONError {
                                
                failure(error.rawValue)
                
            } catch let error as NSError {
                
                failure(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
    func download(with urlString: String, completion: @escaping (_ filePath: String) -> (), failure: @escaping (String) -> ())
    {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let url = URL(string: urlString)
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            if let tempLocalUrl = tempLocalUrl, error == nil {
                
                do {
                    
                    let fileName = url?.lastPathComponent
                    
                    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
                    let documentDirectory = paths[0] 
                    let myFilePath = documentDirectory.appending(fileName!)
                    
                    if FileManager.default.fileExists(atPath: myFilePath) {
                        
                        try FileManager.default.removeItem(atPath: myFilePath)
                    }
                    
                    let fileUrl = URL(string: "file://\(myFilePath)")
                    
                    try FileManager.default.copyItem(at: tempLocalUrl, to: fileUrl!)
                    
                    completion(myFilePath)
                    
                } catch (let writeError) {
                    
                    failure(writeError.localizedDescription)
                }
                
            } else {
                
                failure((error?.localizedDescription)!)
            }
        }
        task.resume()
    }
}

    //MARK: - UIImageView extension

extension UIImageView {
    
    func downloadImage(url: String, placeholder: UIImage, activityIndicatorLarge: Bool) {
        
        let activityIndicator = UIActivityIndicatorView()
        
        if activityIndicatorLarge {
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            
        } else {
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        }
        
        activityIndicator.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        activityIndicator.color = UIColor(red: 150/255, green: 45/255, blue: 62/255, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        
        self.addSubview(activityIndicator)
        
        DispatchQueue.main.async {
            
            activityIndicator.startAnimating()
            self.image = placeholder
        }
        
        NetworkManager.shared.download(with: url, completion: { (filePath) in
            
            let image = UIImage(contentsOfFile: filePath)
            
            DispatchQueue.main.async {
                
                activityIndicator.stopAnimating()
                self.image = image
            }
            
        }) { (error) in
            
            DispatchQueue.main.async {
                
                activityIndicator.stopAnimating()
            }
        }
    }
}

