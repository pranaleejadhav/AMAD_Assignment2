//
//  HomeScreenViewController.swift
//  MAD_Assignment1
//
//  Created by Pranalee Jadhav on 8/28/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class HomeScreenViewController: UIViewController{
    
    @IBOutlet weak var welcome_lb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        // set welcome message
        let uname = UserDefaults.standard.string(forKey: "username")
        welcome_lb.text = "Welcome " + uname!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func showProfile(_ sender: Any) {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        
        //redirect to profile page
        let newViewController: ViewProfileController = storyboard.instantiateViewController(withIdentifier: "ViewProfileController") as! ViewProfileController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        //clear userdefaults to logout user
        
        SVProgressHUD.show()
        post_logoutrequest(parameters: ["token":UserDefaults.standard.string(forKey: "token")!], handler: {
            data in
             SVProgressHUD.dismiss()
            switch(data){
            case 0: self.showMsg(title: "Oops!", subTitle: "No Internet")
                break
            case 2:
                UserDefaults.standard.removeObject(forKey: "token")
                UserDefaults.standard.removeObject(forKey: "username")
                DispatchQueue.main.async(execute: {
                    
                    NotificationCenter.default.post(name: Notification.Name("com.mad.showhomescreen"), object: self, userInfo: nil)
                    
                })
                break
            case 3:self.showMsg(title: "Error", subTitle: "Please try again")
                break
            default:
                self.showMsg(title: "Error", subTitle: "Please try again")
                
            }
            
           
            
        })
    }
    
    func showMsg(title: String, subTitle: String) -> Void {
        let alertController = UIAlertController(title: title, message:
            subTitle, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
