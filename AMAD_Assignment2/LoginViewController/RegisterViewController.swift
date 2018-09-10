//
//  RegisterViewController.swift
//  MAD_Assignment1
//
//  Created by Pranalee Jadhav on 8/28/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import Foundation
import UIKit
import IHKeyboardAvoiding
import SVProgressHUD



class RegisterViewController: UIViewController,UITextViewDelegate{
    //create reference to storyboard views
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var rpwd: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         KeyboardAvoiding.avoidingView = self.scrollView

        //change address box text and border color
        address.delegate = self
        address.text = "Enter your address"
        address.textColor = .lightGray
        
        address.layer.borderColor = UIColor.lightGray.cgColor
        address.layer.borderWidth = 1.0
        address.layer.cornerRadius = 5
        
    }
    
    //called when register button is clicked
    @IBAction func register(_ sender: Any) {
        let uname: String = (name.text?.trimmingCharacters(in: .whitespaces))!
        let pwd: String = (self.pwd.text?.trimmingCharacters(in: .whitespaces))!
        let age: String = (self.age.text?.trimmingCharacters(in: .whitespaces))!
        let rpwd: String = (self.rpwd.text?.trimmingCharacters(in: .whitespaces))!
        let weight: String = (self.weight.text?.trimmingCharacters(in: .whitespaces))!
        let address: String = (self.address.text?.trimmingCharacters(in: .whitespaces))!
        
        //validate input values
        if ((uname.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter username")
        } else if ((uname.count) < 5) {
            showMsg(title: "", subTitle: "Username must be atleast 5 characters long")
        } else if ((pwd.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter password")
        } else if ((pwd.count) < 6) {
            showMsg(title: "", subTitle: "Password must be atleast 6 characters long")
        }else if ((rpwd.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please re-enter password")
        } else if (rpwd != pwd) {
            showMsg(title: "", subTitle: "Passwords do not match")
        } else if ((age.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter age")
        } else if ((Int(age)!) < 17) {
            showMsg(title: "Oops!", subTitle: "Age must be atleast 18 years")
        } else if ((weight.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter weight")
        }else if ((address.isEmpty) == true) {
            showMsg(title: "", subTitle: "Please enter address")
        }
        else{
            //pass parameters to register api
            let str:String=uname+"@gmail.com"
            let params = ["name": uname, "password": pwd, "email":str,"age":age,"weight":weight,"address":address]
            SVProgressHUD.show()
            post_registerrequest(parameters: params, handler: {(data) in
                SVProgressHUD.dismiss()
                switch(data){
                case 0: self.showMsg(title: "Oops!", subTitle: "No Internet")
                break
                case 2:
                    UserDefaults.standard.set(uname, forKey: "username")
                    DispatchQueue.main.async(execute: {
                        
                        NotificationCenter.default.post(name: Notification.Name("com.mad.showhomescreen"), object: self, userInfo: nil)
 
                    })
                    break
                case 3:self.showMsg(title: "Oops!", subTitle: "User already exists")
                    break
                default:
                    self.showMsg(title: "Error", subTitle: "Please try again")
                    
                }
            }
                
            )
            
        }
        
        
    }
    
    //show alert box
    func showMsg(title: String, subTitle: String) -> Void {
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: title, message:
            subTitle, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        })
    }
   
    //Dismiss view controller
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /**to perform operations when focus is on and out of textview **/
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Enter your address")
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
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
