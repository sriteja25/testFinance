//
//  CardDetailsViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 14/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var bankNameSave:String = ""
var accountNumberSave:String = ""

class CardDetailsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    var initialBank:String = ""
    var initialBankImage:UIImage? = nil
    
    
    var creditLimitSave:String = ""
    var cardTypeSave = ""
    
    
    @IBOutlet weak var bankSegmented: UISegmentedControl!
    var bankArray = ["SBI","ICICI","HDFC","Axis","BOI","Others"]
    
    @IBOutlet weak var bankNameText: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var bankImage: UIImageView!
    
    @IBOutlet weak var errorBank: UILabel!
    
    @IBOutlet weak var creditLimit: UILabel!
    
    
    @IBOutlet weak var creditLimitTextField: UITextField!
    
    @IBOutlet weak var accountNumber: UITextField!
    
   
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var cancelCredit: UIButton!
    
    
    @IBOutlet weak var submitCredit: UIButton!
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    @IBOutlet weak var creditLimitRequired: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
       
        
        errorBank.isHidden = true
        bankPicker.isHidden = true
        doneButton.isHidden = true
        creditLimit.isHidden = true
        creditLimitTextField.isHidden = true
        
        cancelCredit.isHidden = true
        submitCredit.isHidden = true
        cardTypeSave = "Debit Card"
        creditLimitRequired.isHidden = true
        
        self.bankNameText.delegate = self
        self.creditLimitTextField.delegate = self
        self.accountNumber.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// Picker view to pick Bank Name and fill the details of the text field.
    
    @IBOutlet weak var bankPicker: UIPickerView!
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        initialBank = bankArray[row]
        
        return bankArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return bankArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        bankNameText.text = bankArray[row]
        
        
// Relevant image will be shown in the image view according to selected the Bank name
        
        
        if(bankNameText.text == "SBI"){
         
          
         bankImage.image = UIImage(named: "sbi.jpg")!
         initialBankImage? = bankImage.image!
            
        }
        if(bankNameText.text == "ICICI"){
            
            bankImage.image = UIImage(named: "icici.jpg")!
            initialBankImage? = bankImage.image!
        }
        if(bankNameText.text == "HDFC"){
            
            bankImage.image = UIImage(named: "hdfc card.png")!
            initialBankImage? = bankImage.image!
        }
        if(bankNameText.text == "Axis"){
            
            bankImage.image = UIImage(named: "axis.jpg")!
            initialBankImage? = bankImage.image!
        }
        if(bankNameText.text == "BOI"){
            
            bankImage.image = UIImage(named: "boi.jpg")!
            initialBankImage? = bankImage.image!
        }
        if(bankNameText.text == "Others"){
         
            bankImage.image = nil
            errorBank.isHidden = false
            
        }
        
        
    }
    
//When text field is selected
    
    @IBAction func bankNameTextFieldAction(_ sender: UITextField) {
        
        bankNameText.text = initialBank
        bankImage.image = initialBankImage
        
        bankNameText.isUserInteractionEnabled = false
        
        doneButton.isHidden = false
        bankPicker.isHidden = false
        bankPicker.dataSource = self
        bankPicker.delegate = self
    }
    
//When Bank name text field editing is ended
   
    @IBAction func bankNameEditingDidEnd(_ sender: AnyObject) {
        bankPicker.isHidden = true
        doneButton.isHidden = true
    }
    
// When "X" button is pressed on the picker view.
    
    @IBAction func donePickerView(_ sender: AnyObject) {
        
        bankPicker.isHidden = true
        doneButton.isHidden = true
        
    }
    
//Segment view control for debit and credit card
    
    @IBAction func segmentViewAction(_ sender: UISegmentedControl) {
        
        switch bankSegmented.selectedSegmentIndex
        {
            
       //Debit card
            
        case 0: creditLimit.isHidden = true
        creditLimitTextField.isHidden = true
            bankImage.image = nil
            bankNameText.text = nil
            accountNumber.text = nil
            bankPicker.isHidden = true
            errorBank.isHidden = true
            cancelCredit.isHidden = true
            submitCredit.isHidden = true
            cancelButton.isHidden = false
            submitButton.isHidden = false
            doneButton.isHidden = true
            cardTypeSave = "Debit Card"
            creditLimitRequired.isHidden = true
            
            
            
       //Credit card
            
            
        case 1: creditLimit.isHidden = false
            creditLimitTextField.isHidden = false
            bankImage.image = nil
            bankNameText.text = nil
            accountNumber.text = nil
            bankPicker.isHidden = true
            errorBank.isHidden = true
            doneButton.isHidden = true
            cancelCredit.isHidden = false
            submitCredit.isHidden = false
            cancelButton.isHidden = true
            submitButton.isHidden = true
            cardTypeSave = "Credit Card"
            creditLimitRequired.isHidden = false
            
       
        
        default:
            break;
        }
    }
    
//Saving the details entered by the user in Firebase
    
    func cardDetailsSave(){
        
        
     let   saveDetails  = ["Salary" : "","Investments":"","Savings":""] as [String : Any]
        
      
        
      let cardDetails =   ["Bank Name" : bankNameSave ,  "Account Number": accountNumberSave,  "Credit Card Limit": creditLimitSave, "Card Type" :cardTypeSave]
        
        databaseRef = FIRDatabase.database().reference()
        
        
        
       // databaseRef.child("Details").updateChildValues(saveDetails)
        
        databaseRef.child("Details").child("Users").child(userId).child("Income").setValue(saveDetails)
        
    
        
        databaseRef.child(byAppendingPath: "Details").child(byAppendingPath: "Users").child(byAppendingPath: userId).child("Services enrolled").child("Cards").setValue(cardDetails)
        
        
    
    }
    

    @IBAction func cardDetailsSaveButton(_ sender: AnyObject) {
        
        
        
    }
        
    @IBAction func submitDebitSaveButton(_ sender: AnyObject) {
        
        
        
    }
    
    
    @IBAction func cancelButtonDebit(_ sender: AnyObject) {
    }
    
//If any text field is empty during entering Debit card details, Pop up an alert view to ask user to fill all the required text fields
    
    
    @IBAction func submitDebitButton(_ sender: AnyObject) {
        
        
        if(bankNameText.text == ""){
            
           
                let alert = UIAlertController(title: "Error", message: "Please enter all the required Fields ", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            
        }
        else if (accountNumber.text == ""){
            
            let alert = UIAlertController(title: "Error", message: "Please enter all the required Fields ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        
        
        }
            
            
    //Open Basic information View controller  BasicInfoViewController.swift          
            
            else{
        
            performSegue(withIdentifier: "debitSubmit" , sender: nil)
            
            bankNameSave = bankNameText.text!
            accountNumberSave = accountNumber.text!
            
            cardDetailsSave()
            
        }
        
    }
    
//If any text field is empty during entering Credit card details, Pop up an alert view to ask user to fill all the required text fields
    
    
    @IBAction func submitCreditButton(_ sender: AnyObject) {
        
        if(bankNameText.text == "" ){
            
            
            let alert = UIAlertController(title: "Error", message: "Please enter all the required Fields ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }else if(accountNumber.text == "" ){
            
            let alert = UIAlertController(title: "Error", message: "Please enter all the required Fields ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        
        
        }else if(creditLimitTextField.text == ""){
            
            let alert = UIAlertController(title: "Error", message: "Please enter all the required Fields ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        
        
        }
            
        else{
            
            
  //Open Basic information View controller  BasicInfoViewController.swift
            
            performSegue(withIdentifier: "debitSubmit" , sender: nil)
            
            bankNameSave = bankNameText.text!
            accountNumberSave = accountNumber.text!
            creditLimitSave = creditLimitTextField.text!
            
            cardDetailsSave()
            
        }
        
        
    }
    
    
    // Hide keyboard on pressing return key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    

}
    
    
    
    
    

