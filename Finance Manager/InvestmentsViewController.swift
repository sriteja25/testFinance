//
//  InvestmentsViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 15/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit

var compName:String = ""

class InvestmentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var companyName: UITextField!

    @IBOutlet weak var numberOfStocks: UITextField!
    
    @IBAction func addInvestments(_ sender: AnyObject) {
        
        compName = companyName.text!
        }
    
    // Hide keyboard on pressing return key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
}
