//
//  ListViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

enum URLS: String {
    
    case testJson = "http://test.php-cd.attractgroup.com/test.json"
}

enum ImageNames: String {
    
    case placeholder = "placeholder"
}

extension Date {
    
    func formattedDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMMM-YYYY HH:mm"
        
        let date = dateFormatter.string(from: self)
        
        return date
    }
}

class ListViewController: UIViewController, ReuseIdentifierProtocol, ViewControllerTransitionProtocol {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: TableView!
    
    var list: Array<StuffModel> = []
    var allStuff: Array<StuffModel> = []
    
    //MARK: -  Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaultCancelButtonColor()
        
        self.getAndSetStuff()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Stuff methods
    
    func getAndSetStuff() {
        
        NetworkManager.shared.getList(with: URLS.testJson.rawValue, completion: { (jsonArray) in
            
            for dict in jsonArray {
                
                let stuff = StuffModel(with: dict as! Dictionary<String, Any>)
                
                self.list.append(stuff)
                self.allStuff.append(stuff)
            }
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }

        }) { (error) in }
    }
    
    // MARK: - UISearchBar custom methods
    
    func defaultCancelButtonColor() {
        
        let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.gray]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String : AnyObject], for: UIControlState.normal)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        
        self.list = self.allStuff.filter { $0.name == searchBar.text }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.endEditing(true)
        
        if self.list.count < self.allStuff.count {
            
            self.list = self.allStuff
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count == 0 {
            
            self.list = self.allStuff
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell:StuffCell = tableView.dequeueReusableCell(withIdentifier: StuffCell.reuseIdentifier) as! StuffCell!
        
        let stuff = self.list[indexPath.row]
        
        cell.stuffNameLabel.text = stuff.name
        cell.stuffDateLabel.text = stuff.date?.formattedDate()
        cell.stuffImageView.downloadImage(url: stuff.imageUrl!,
                                          placeholder: UIImage(named: ImageNames.placeholder.rawValue)!,
                                          activityIndicatorLarge: false)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.list.count == 1 {
            
            let detailViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            detailViewController.add(stuff: self.list[indexPath.row])
            
            self.add(asChildViewController: detailViewController, animated: true) {}
            
        } else {
            
            let pagesViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "PagesViewController") as! PagesViewController
            
            pagesViewController.stuff(list: self.list, selectedIndex: indexPath.row)
            
            self.add(asChildViewController: pagesViewController, animated: true) {
                
                self.tableView.alpha = 0
                self.searchBar.alpha = 0
            }
        }
    }
}
