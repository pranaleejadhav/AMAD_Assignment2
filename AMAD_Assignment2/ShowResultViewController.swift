//
//  ShowResultViewController.swift
//  AMAD_Assignment2
//
//  Created by Pranalee Jadhav on 9/10/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import Foundation
import UIKit

class ShowResultViewController: UIViewController{
    
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var scoreLb: UILabel!
    @IBOutlet weak var zoneLb: UILabel!
    @IBOutlet weak var courseLb: UILabel!
    @IBOutlet weak var boxView: UIView!
    
    var scores:Int = 0
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set navigation bar title
        self.title = "Survey Report"
        
        self.navigationItem.hidesBackButton = true
        
        boxView.layer.borderWidth = 1
        
        boxView.layer.borderColor = UIColor.gray.cgColor
        
        print(scores)
        nameLb.text = (UserDefaults.standard.string(forKey: "username"))?.capitalized
        scoreLb.text = String(scores)
        
        if scores<8{
            zoneLb.text = "Zone I"
            courseLb.text = "Alcohol Education"
        } else if scores<16{
            zoneLb.text = "Zone II"
            courseLb.text = "A brief intervention using simple advice and patient education materials is the most appropriate course of action."
        } else if scores<20{
            zoneLb.text = "Zone III"
            courseLb.text = "Harmful and hazardous drinking can be managed by a combination of simple advice, brief counseling and continued monitoring, with further diagnostic evaluation indicated if the patient fails to respond or is suspected of possible alcohol dependence."
        } else if scores<41{
            zoneLb.text = "Zone IV"
            courseLb.text = "Should refer to a specialist for diagnostic evaluation and possible treatment for alcohol dependence. If these services are not available, the patient can be given primary care, especially when mutual help organizations are able to provide community-based support."
        }
        
    }
}
