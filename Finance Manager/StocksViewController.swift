//
//  StocksViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 15/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class StocksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        Alamofire.request("https://www.google.com/finance/info?q=NSE:\(compName)")
            .responseString { response in
                guard let responseString = response.result.value else {
                    print("ERROR: didn't get a string in the response")
                    return
                }
                
// get rid of leading characters "\n// "
                
                let leadingCharactersToTrim = CharacterSet(charactersIn: "/").union(.whitespacesAndNewlines)
                let trimmedString = responseString.trimmingCharacters(in: leadingCharactersToTrim)
                
// turn the string into a JSON dictionary
                
                var json: [[String: Any]]?
                if let data = trimmedString.data(using: .utf8) {
                    do {
                        json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    } catch {
                        print(error.localizedDescription)
                        return
                    }
                }
                
// Json  after removing the Leading charecters.
                
                
                print("\(json)")
                if let stockInfo = json?[0] {
                    if let name = stockInfo["t"] as? String {
                        print("Teja\(name)")
                        
                        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                        label.center = CGPoint(x: 100, y: 285)
                        label.textAlignment = .center
                        label.text = name
                        self.view.addSubview(label)
                    }
                    if let value = stockInfo["l"] as? String {
                        print("Teja\(value)")
                        
                        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                        label.center = CGPoint(x: 200, y: 285)
                        label.textAlignment = .center
                        label.text = value
                        self.view.addSubview(label)
                    }
                    
                    if let cp = stockInfo["cp"] as? String{
                    
                        let cpLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                        cpLabel.center = CGPoint(x: 300, y: 285)
                        cpLabel.textAlignment = .center
                        cpLabel.text = cp
                        self.view.addSubview(cpLabel)
                    }
                    
                    if  let c = stockInfo["c"] as? String{
                    
                        let cLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                        cLabel.center = CGPoint(x: 350, y: 285)
                        cLabel.textAlignment = .center
                        cLabel.text = c
                        self.view.addSubview(cLabel)
                    
                    }
                    
                    
                    

                    
                    
                    
                }
        }
    }
        
        
       
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    // Hide keyboard on pressing return key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
   
   
    

   

}
