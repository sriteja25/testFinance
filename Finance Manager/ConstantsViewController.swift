//
//  ConstantsViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 19/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


var userId :String = ""

var firsName:String = ""

var lastName:String = ""

var Place:String = ""

var DOB:String = ""

var varView = Int()


var databaseRef = FIRDatabase.database().reference()

//Hiding a keyboard

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


let key_UID = "uid"
