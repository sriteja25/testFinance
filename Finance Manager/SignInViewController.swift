//
//  ViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 13/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import SwiftKeychainWrapper

var xyz:String = ""

class SignInViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate,UITextFieldDelegate {

    @IBOutlet weak var emailIDEntered: UITextField!
    
    
    @IBOutlet weak var pwdEntered: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        
        self.emailIDEntered.delegate = self
        self.pwdEntered.delegate = self
        
       
        
        
   }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: key_UID){
            
            performSegue(withIdentifier: "signedIn", sender: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    
    }


//Facebook sign in Button pressed
    
    @IBAction func fbSignInButton(_ sender: AnyObject) {

    
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Kichu : Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Kichu : User cancelled Facebook authentication")
            } else {
                print("Kichu : Successfully authenticated with Facebook")
                
            }
            
         let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
           self.firebaseAuth(credential)
            
            
        }
    
    }
   
    
//Firebase Authentication for facebook signin / Sign up
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                
                print("Firebase authentication failed")
            }
                
            
            else {
                print("JESS: Successfully authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                   print("Kichu : Sign in Complete")
   
                    userId = user.uid
                    
                   self.CompleteSignin(userId)
                    
                    self.performSegue(withIdentifier:"signedIn", sender: nil)
                    
                    varView = 1
                }
            }
        })
    }
    
    
// Custom Signin Button pressed. This will also add the email id of the user to new signup if an account Doesn't exist.
    
    @IBAction func signinButtonPressed(_ sender: AnyObject) {
        
        if let email = emailIDEntered.text, let pwd = pwdEntered.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("JESS: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        print(" Sign in EMail Complete")
                        
                        print(" \(user.uid) +++++++  \(user.providerID)")
                        
                        userId = user.uid
                        
                        self.CompleteSignin(userId)
                        
                        self.performSegue(withIdentifier:"signedIn", sender: nil)
                        
                        
                 
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            
                            let alert = UIAlertController(title: "Email ID or Password is incorrect", message: "Please enter a valid Email ID or a Password ", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil)

                        } else {
                            print("JESS: Successfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                print("Sign up  Email Complete")
                                
                                userId = user.uid
                                
                                 print(" \(user.uid) +++++++  \(user.providerID)")
                                
                                self.performSegue(withIdentifier:"getUserInfo", sender: nil)
                                
                                self.CompleteSignin(userId)
                                
                                varView = 1
                            }
                        }
                    })
                }
            })
        }

        
    }
    
//Google sign in
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
        print(error.localizedDescription)
        }
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if(error != nil)
            {
                print(error?.localizedDescription)
                
                let alert = UIAlertController(title: "Email ID or Password is incorrect", message: "Please enter a valid Email ID or a Password ", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            else{
                print("Logged in Sucessfully")
                
                
                self.performSegue(withIdentifier:"signedIn", sender: nil)
                
                self.CompleteSignin(userId)
                
                
            }
        })

    }
    
//Sign out button pressed
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error{
            print(error.localizedDescription)
        }
    try! FIRAuth.auth()?.signOut().self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    func CompleteSignin(_ id :String){
    
    KeychainWrapper.standard.set(id, forKey: key_UID)
        
        
        
    }
 
    
    
    

}

