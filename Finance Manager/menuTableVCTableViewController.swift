//
//  menuTableVCTableViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 24/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit

class menuTableVCTableViewController: UITableViewController {

    var menuArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

         menuArray = ["Home","My Page","Transactions","My Challenges and Rewards","Edit Profile"]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: menuArray[indexPath.row] , for: indexPath)
        
        cell.textLabel?.text = menuArray[indexPath.row]
        
        return cell
    }
 

}
