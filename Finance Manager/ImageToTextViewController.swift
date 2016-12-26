//
//  TestViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 20/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Foundation
import TesseractOCR
import ImagePicker



    


class ImageToTextViewController: UIViewController,G8TesseractDelegate,ImagePickerDelegate {
    
    let imagePickerController = ImagePickerController()
    
   
    
    @IBOutlet weak var billImageView: UIImageView!
    
    
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.hideKeyboardWhenTappedAround()

        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = UIImage(named: "bill2.png")?.g8_blackAndWhite()
            tesseract.recognize()
            
            var str:String = tesseract.recognizedText
    
           
            var strNew:String = ""
            
            
           
      
            
    
        
            
     if ((str.range(of: "Total")) != nil){
         
         let keyWord =  str.range(of: "Total")
            
            let wordUpperBound = keyWord?.upperBound
            
             strNew = str.substring(from: wordUpperBound!)
         
         }
            
            var test = strNew.components(separatedBy: .letters).joined(separator: ",")
            
            print("Teja123 \(test)")
            
            
            
            var symboRemover = test.components(separatedBy: .symbols).joined(separator: " ")
            
            print("Teja123 \(symboRemover)")
            
            var punchuationRemover = symboRemover.components(separatedBy: ":").joined(separator: "")
            
            var nlRemover = punchuationRemover.components(separatedBy: "\n").joined(separator: "")
            
            
            var spaceRemover = nlRemover.components(separatedBy: " ")
            
            
            
            
            print("Teja123 \(spaceRemover)")
            print("Teja123 \(nlRemover)")
            
            var larg:Float = 0
            var curr:Float = 0
            
            for var i in 0..<spaceRemover.count{
            
                var num = Float(spaceRemover[i])
                if num != nil {
                    
                    curr = num!
                    
                    if(curr > larg){
                    
                    larg = curr
                    
                    }
                
                
                }
                else {
                    print("Not Valid Integer")
                }
            
            }
         
         print("Kichu95 \(larg)")
            
            textField.text = "\(larg)"
         
        
            
        
        }
        
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        
        print("Recognition Progress \(tesseract.progress) %")
        
        }
}
    
    
    @IBAction func uploadButton(_ sender: AnyObject) {
        
        
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.imageLimit = 1
       
        
        
        
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        
        imagePickerController.imageLimit = 1
    
    
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
    
        imagePicker.dismiss(animated: true, completion: nil)
        
        imagePickerController.imageLimit = 1
        
        billImageView.image = images[0]
        
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController){
    
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
 
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}


