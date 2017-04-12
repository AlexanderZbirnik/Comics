//
//  NetworkManager.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit
import Foundation

enum JSONError: String, Error{
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class NetworkManager: NSObject{
    
    static let shared = NetworkManager()
    
    func getList(with urlString: String, completion: @escaping (Array<Any>) -> (), failure: @escaping (String) -> ()) {
        
        //Fake response
        
        let jsonArray =
            [["itemId":"10056","name":"IronMan","image":"https://www.sideshowtoy.com/photo_902224_thumb.jpg","description":"Iron Man is one of the most widely known superheroes in the world. Anthony Edward \"Tony\" Stark was born with extreme intelligence. After the death of his parents when he was 21, Stark inherited Stark Enterprises. After being wounded while in a war zone, he built an armored suit that would help to keep him alive. Stark helped to organize the superhero team, The Avengers early in his career as a superhero. Originally, Tony Stark had no powers of his own, and he depended on his armored suit for all of his superhuman abilities, until he injected himself with the Extremis virus and later had an R.T. node implanted in his chest, gaining new abilities and intellect. Iron Man was created by Stan Lee, Larry Lieber, Don Heck and Jack Kirby, first appearing in Tales of Suspense #39. (1963)","time":"1457018867393"],
             ["itemId":"10054","name":"Deadpool","image":"https://www.sideshowtoy.com/photo.php?sku=3005111","description":"Wade Wilson was an international assassin who had worked for various governments when he developed an aggressive cancer. In an effort to find a cure, he enrolled in the Weapon X program in Canada, which gave him a healing factor from another member and set him to work for them. When he killed a team member, he was thrown out of the program and was sent to have his abilities removed, where he was experimented on instead. The results of his stay there were a diminished mental state, a healing factor that could not cure his cancer or heal his scars, an infatuation with death, and his freedom to return to for-hire mercenary work. As \"The Merc with a Mouth\" he set out as Deadpool to kill and have a good time doing it. Deadpool was created by Fabian Nicieza and Rob Liefeld, first appearing in New Mutants #98. (1991)","time":"1457018837658"],
             ["itemId":"10028","name":"Thor","image":"http://cdn.buzzkix.com/wp-content/uploads/2016/02/Thor_Avengers2.png","description":"Leaping from the legends of Norse mythology, the Asgardian God of Thunder, Thor, is the son of Odin the All-Father and Jord, the spirit of the Earth. He frequently stands alongside the Avengers in the defense of the people of Midgard (Earth), often against the schemes of his adopted brother Loki. He formerly dwelt in a recreation of Asgard in Oklahoma, using the mortal form of Donald Blake to provide a bridge between his people and the mortals surrounding them. However, Loki's subtle trickery and manipulations of Balder, combined with her time-twisting of Asgard's past and that of Bor and Odin's has enabled her to banish Thor from Asgard, stripping him of his titles, throne and legal power, and move his people to Doctor Doom's Latveria, having planned this ever since her rebirth. Thor returned to Asgard, just in time to aid them in a battle against Norman Osborn's Dark Avengers, X-Men, and H.A.M.M.E.R. forces, killing Sentry after he destroyed Asgard. Feeling lonely, Thor has resurrected his brother Loki and father Odin and they continue to battle-on for the survival of Asgard.","time":"1457018877305"],
             ["itemId":"10048","name":"Hulk","image":"https://pbs.twimg.com/profile_images/791863059241312256/hICiK45A.jpg","description":"Bruce Banner was a scientist who was working on a gamma bomb when he noticed teenager Rick Jones out on the test range. Although he rushed out into the test site and heroically pushed the boy into the protective trench to save him from the blast, Bruce was exposed to extreme amounts of gamma radiation that altered his DNA structure due to gamma rays and trauma passed down by his Father and caused him to become a giant green (at first grey) monster of incredible power whenever he starts to get angry. With his girlfriend Betty Ross seemingly being the only person able to calm the Hulk back into Banner, and often being pursued by his nemesis Thunderbolt Ross who is also Betty's Father, Bruce is often on the run while trying to find a cure for his problem and keep calm as much as he can while at the same time battling super-villains. Hulk was created by Stan Lee and Jack Kirby in 1962, first appearing in Incredible Hulk #1.","time":"1457018788101"],
            ["itemId":"10077","name":"Captain America","image":"http://cdn3-www.superherohype.com/assets/uploads/gallery/captain_america_4979/captain_america_the_winter_soldier_7927/captws_captainamerica_avatar.jpg","description":"During the dark days of the early 1940's, a covert US military experiment turned Steve Rogers into America's first Super-Soldier, Captain America. Throughout the war, Cap and his partner Bucky Barnes fought alongside infantry and with a group of heroes known as the Invaders. In the closing months of World War II, Captain America and Bucky were both presumed dead in an explosion. Few decades later, Captain America was found trapped in ice and revived in the modern world. As a symbol of freedom and patriotism, a number of men have taken the mantel of Captain America in Rogers' various absences. Of note are William Nasland and Jeffrey Mace, Bucky Barnes, and Sam Wilson. Also, a Zombie Steve Rogers, Roberta Mendez from 2099, and Danielle Cage from 20XX are trapped in Earth-616. Additional information on a number of other men to act as Captain America over the years is listed below, in the Others section.","time":"1457018788101"]]
        
        completion(jsonArray)
        
        // real get method
        
        
//        let url:URL = URL(string: urlString)!
//        let session = URLSession.shared
//        
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
//
//            do {
//                
//                guard let data = data else {
//                    
//                    throw JSONError.NoData
//                }
//                
//                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Any> else {
//                    
//                    throw JSONError.ConversionFailed
//                }
//                
//                completion(jsonArray)
//                
//            } catch let error as JSONError {
//                                
//                failure(error.rawValue)
//                
//            } catch let error as NSError {
//                
//                failure(error.localizedDescription)
//            }
//        })
//        
//        task.resume()
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

