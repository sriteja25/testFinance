//
//  EwalletViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 14/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class EwalletViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

  
    
    var eWalletArray = ["Paytm","Freecharge","Jiomoney","Buddy"]
    
    var serviceSave:String = ""
    var mobileNumberSave = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        eWalletPicker.isHidden = true
        donePicker.isHidden = true
        
        self.serviceNameField.delegate = self
        self.mobileNumberField.delegate = self
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBOutlet weak var serviceNameField: UITextField!

    @IBOutlet weak var mobileNumberField: UITextField!
    
    @IBOutlet weak var eWalletPicker: UIPickerView!

    @IBOutlet weak var cancelEwallet: UIButton!
    
    @IBOutlet weak var submitEwallet: UIButton!
    
    @IBOutlet weak var eWalletImage: UIImageView!
    
    @IBOutlet weak var donePicker: UIButton!
    
    
   //Picker view for selecting the e-wallet of user
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return eWalletArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return eWalletArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        serviceNameField.text = eWalletArray[row]
        
        if(serviceNameField.text == "Paytm"){
            
            eWalletImage.image = UIImage(named: "paytm.png")!
        }
        if(serviceNameField.text == "Freecharge"){
            
            eWalletImage.image = UIImage(named: "freecharge.png")!
        }
        if(serviceNameField.text == "Jiomoney"){
            
            eWalletImage.image = UIImage(named: "jio money.jpg")!
        }
        if(serviceNameField.text == "Buddy"){
            
            eWalletImage.image = UIImage(named: "buddy.png")!
        }
        
        
    }
    
//Service name text field started editing
    
    @IBAction func serviceNameTextField(_ sender: AnyObject) {
        
        eWalletPicker.delegate = self
        eWalletPicker.dataSource = self
        
        donePicker.isHidden = false
        eWalletPicker.isHidden = false
        
        serviceNameField.text = eWalletArray[0]
        eWalletImage.image = UIImage(named: "paytm.png")!
        
        serviceNameField.isUserInteractionEnabled = false
        
        
        
    }
    
//Service name text field ended editing
    
    @IBAction func serviceNameTextEnd(_ sender: AnyObject) {
        eWalletPicker.isHidden = true
        donePicker.isHidden = true

    }
    
//Clicking on "X" button on the picker view
    
    @IBAction func exitPicker(_ sender: AnyObject) {
        
        eWalletPicker.isHidden = true
        donePicker.isHidden = true
        
    }
    
    
//Saving the e-wallet details entered by the user in the Firebase database
    
    
    func eWalletDBSave(){
        
        
    
        let saveDetails  = ["Service Name" : serviceSave ,  "Mobile Number": mobileNumberSave] as [String : Any]
        
        databaseRef = FIRDatabase.database().reference()
        
        
        
        
      
        
        databaseRef.child(byAppendingPath: "Details").child(byAppendingPath: "Users").child(byAppendingPath: userId).child("Services enrolled").child("E-Wallet").setValue(saveDetails)
    
     
    }
    
    
    @IBAction func submitButtonPressed(_ sender: AnyObject) {
        
        
    }
    
//If any text field required to be entered is empty an alert view controller will be poped up asking user to fill all the required text fields.
    
    @IBAction func noEmptyTextFieldsSubmit(_ sender: AnyObject) {
        
        if(serviceNameField.text == ""){
            
            let alert = UIAlertController(title: "Error", message: "Please enter all the required Fields ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        
        
        } else if (mobileNumberField.text == ""){
            
            
            let alert = UIAlertController(title: "Error", message: "Please enter all the required Fields ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
//If all the required text fields are entered the details will be saved in DB and will return back to BasicInfoVIewCOntroller.swift view controller.
            
        else{
            
            performSegue(withIdentifier: "eWalletSubmitView" , sender: nil)
            
            serviceSave = serviceNameField.text!
            mobileNumberSave = mobileNumberField.text!
            
            eWalletDBSave()
            
        }
    }
    
    
    // Hide keyboard on pressing return key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    
    
}
