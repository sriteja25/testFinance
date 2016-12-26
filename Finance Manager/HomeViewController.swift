//
//  HomeViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 24/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
       view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        menu2Button.target = self.revealViewController()
        menu2Button.action = #selector(SWRevealViewController.revealToggle(_:))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var menu2Button: UIBarButtonItem!
    
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "signedOut", sender: nil)
        
        KeychainWrapper.standard.removeObject(forKey: key_UID, withAccessibility: nil)
        
        try! FIRAuth.auth()!.signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            
            self.present(vc, animated: true, completion: nil)
        }
        
        performSegue(withIdentifier: "signedOut", sender: nil)
        
        
    }

}
