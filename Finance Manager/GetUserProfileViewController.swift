//
//  GetUserProfileViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 22/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Eureka

class GetUserProfileViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     // let  profile = ["Name" : "","Age": "","Email Id": "","Place" : ""]
        
      //   databaseRef.child(byAppendingPath: "Details").child(byAppendingPath: "Users").child(byAppendingPath: userId).child("Profile").setValue(profile)

        

        form = Section("Basic Details")
            <<< TextRow(){ row in
                row.title = "First Name"
                row.placeholder = "Enter First Name"
            }
            <<< TextRow(){ row in
                row.title = "Last Name"
                row.placeholder = "Enter Last Name "
            }
            <<< PhoneRow(){
                $0.title = "Phone Mobile"
                $0.placeholder = "And numbers here"
            }
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
        
            +++ SegmentedRow<String>(){
                $0.title = "Gender"
                $0.selectorTitle = "Pick a Gender"
                $0.options = ["Male","Female","Other"]
                $0.value = "Male"    // initially selected
        }
        +++ Section("Other Details")
        
            <<< TextRow(){ row in
                row.title = "Salary"
                row.placeholder = "Enter Salary Value"
                }
                <<< PhoneRow(){ row in
                    row.title = "Number of members in Family"
                    row.placeholder = "Enter a number "
               }
            <<< SwitchRow("Ocupation"){
                $0.title = "Employed"
            }
            <<< TextRow(){
                
                $0.hidden = Condition.function(["Ocupation"], { form in
                    return !((form.rowBy(tag: "Ocupation") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Designation"
                $0.placeholder = "Enter your job designation"
            }
            
       
    
        
    
    
    }
    
    
    
    
    func nextButtonPressed(sender :UIButton!){
        
        var btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
           
             performSegue(withIdentifier: "cardDetails", sender: nil)
        }
        
       
        
        
    }
    
    
    
}






