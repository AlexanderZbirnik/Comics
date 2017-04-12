//
//  DetailViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 26.03.17.
//  Copyright (c) 2017 com.alexzbirnik. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol DetailViewControllerInput {
    
    func displayDetail(viewModel: Detail.Stuff.ViewModel)
}

protocol DetailViewControllerOutput {
    
    func fetchDetail(request: Detail.Stuff.Request)
    var stuff: StuffModel! { get set }
}

class DetailViewController: UIViewController, ReuseIdentifierProtocol, DetailViewControllerInput {
    
    var output: DetailViewControllerOutput!
    var router: DetailRouter!
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DetailConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchDetailOnLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
        self.detailTextView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    // MARK: - Event handling
    
    func fetchDetailOnLoad() {
        
        let request = Detail.Stuff.Request()
        self.output.fetchDetail(request: request)
    }
    
    // MARK: - Display logic
    
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var detailTextView: UITextView!
    
    func displayDetail(viewModel: Detail.Stuff.ViewModel) {
        
        let imageUrl = viewModel.displayStuff.imageUrl
        let placeholder = UIImage(named: viewModel.placeholderName)
        let detail = viewModel.displayStuff.detail
        
        self.detailTextView.text = detail
        
        self.imageView.downloadImage(url: imageUrl,
                                     placeholder: placeholder!,
                                     activityIndicatorLarge: true)
    }
}
