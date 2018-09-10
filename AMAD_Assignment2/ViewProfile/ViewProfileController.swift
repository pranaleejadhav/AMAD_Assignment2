//
//  ViewProfileController.swift
//  MAD_Assignment1
//
//  Created by Pranalee Jadhav on 8/28/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import Foundation
import UIKit
import IHKeyboardAvoiding
import SVProgressHUD

class ViewProfileController: UIViewController,UITextViewDelegate {
    //create reference to storyboard views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var address: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardAvoiding.avoidingView = self.scrollView
        
        //set navigation bar title
        self.title = "My Profile"
        
        //change address box text and border color
        address.delegate = self
        address.text = "Enter your address"
        address.textColor = .lightGray
        
        address.layer.borderColor = UIColor.lightGray.cgColor
        address.layer.borderWidth = 1.0
        address.layer.cornerRadius = 5
        
        show_profile()
        
    }
    
    //fetch profile details from api
    func show_profile() -> Void {
        
        SVProgressHUD.show()
        post_showprofilerequest(parameters:["token":UserDefaults.standard.string(forKey: "token")!], handler: {
            data in
            SVProgressHUD.dismiss()
            if let val = data["code"] as? Int{
                switch(val){
                case 0: self.showMsg(title: "Oops!", subTitle: "No Internet")
                    break
                
                default:
                    self.showMsg(title: "Error", subTitle: "Please try again")
                    
                }
            } else{
                self.uname.text = data["name"] as? String
                self.age.text = data["age"] as? String
                self.weight.text = data["weight"] as? String
                self.address.text = data["address"] as? String
            }
          })
    }
    
    
     //called when submit button is clicked
    @IBAction func submit(_ sender: Any) {
        let uname: String = (self.uname.text?.trimmingCharacters(in: .whitespaces))!
        let age: String = (self.age.text?.trimmingCharacters(in: .whitespaces))!
        let weight: String = (self.weight.text?.trimmingCharacters(in: .whitespaces))!
        let address: String = (self.address.text?.trimmingCharacters(in: .whitespaces))!
        //validate input values
        if ((uname.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter username")
        } else if ((uname.count) < 5) {
            showMsg(title: "", subTitle: "Username must be atleast 5 characters long")
        } else if ((age.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter age")
        } else if (Int(age)! < 17) {
            showMsg(title: "Oops!", subTitle: "Age must be atleast 18 years")
        } else if ((weight.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter weight")
        }else if ((address.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter address")
        }
        else{
           //pass parameters to updateprofile api
            let str:String=uname+"@gmail.com"
            let params = ["name": uname, "email":str,"age":age,"weight":weight,"address":address,"token":UserDefaults.standard.string(forKey: "token")!]
            
             SVProgressHUD.show()
            post_updateprofilerequest(parameters: params, handler: {(data) in
                
                print(data)
                SVProgressHUD.dismiss()
                switch(data){
                case 0: self.showMsg(title: "Oops!", subTitle: "No Internet")
                    break
                case 2:
                    UserDefaults.standard.set(uname, forKey: "username")
                    DispatchQueue.main.async(execute: {
                        
                        
                        self.showMsg(title: "Profile Updated", subTitle: "")
                        
                        
                    })
                    break
                case 3:self.showMsg(title: "Error", subTitle: "Please try again")
                    break
                default:
                    self.showMsg(title: "Error", subTitle: "Please try again")
                    
                }
            }
                
            )
            
            
            
        }
    }
    
    //show alertbox
    func showMsg(title: String, subTitle: String) -> Void {
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: title, message:
            subTitle, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
     /**to perform operations when focus is on and out of textview **/
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Enter your address")
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Enter your address"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
