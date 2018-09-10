//
//  CustomlaunchscreenController.swift
//  MAD_Assignment1
//
//  Created by Pranalee Jadhav on 8/27/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import Foundation
import UIKit

class CustomlaunchscreenController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .seconds(2)
        mainQueue.asyncAfter(deadline: deadline) {
            //post notification after 2 seconds
             NotificationCenter.default.post(name: Notification.Name("com.mad.showhomescreen"), object: self, userInfo: nil)
        }
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}
