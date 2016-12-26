//
//  menuTableView.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 24/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import Foundation

class menuTableView: UITableViewController {
    
    var menuArray = [String]()
    
    override func viewDidLoad() {
    
        menuArray = ["Home","My Page","Transaction History","My Challenges and Rewards","Edit Profile"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return menuArray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = menuArray[indexPath.row]
        
        return cell
    }
    
    
    
    
}
