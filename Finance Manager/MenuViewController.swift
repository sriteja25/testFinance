//
//  MenuViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 23/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var dismissButton: UIButton!
   
    @IBAction func dismissMenu(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
