//
//  TransactionViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 24/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var menuButton: UIBarButtonItem!
    

}
