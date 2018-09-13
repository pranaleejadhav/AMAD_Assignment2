//
//  SurveyViewController.swift
//  AMAD_Assignment2
//
//  Created by Pranalee Jadhav on 9/10/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class SurveyViewController: UIViewController{
    @IBOutlet weak var question_no: UILabel!
    @IBOutlet weak var questionLb: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var option1: UIView!
    @IBOutlet weak var option2: UIView!
    @IBOutlet weak var option3: UIView!
    @IBOutlet weak var option4: UIView!
    @IBOutlet weak var option5: UIView!
    @IBOutlet weak var option1_img: UIImageView!
    @IBOutlet weak var option1_lb: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var option2_img: UIImageView!
    @IBOutlet weak var option2_lb: UILabel!
    
    @IBOutlet weak var option3_img: UIImageView!
    @IBOutlet weak var option3_lb: UILabel!
    
    @IBOutlet weak var option4_img: UIImageView!
    @IBOutlet weak var option4_lb: UILabel!
    
    @IBOutlet weak var option5_img: UIImageView!
    @IBOutlet weak var option5_lb: UILabel!
    
    var imgArr:[UIImageView]=[UIImageView]()
    
    var plistFilePath:String = String()
    var qid:Int = 0
    var questionList:[Dictionary<String,Any>] = [Dictionary<String,Any>]()
    var selectedTag:Int = -1
    var answers = [Int](repeating: 0, count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set navigation bar title
        self.title = "Survey"
        
        imgArr = [option1_img,option2_img,option3_img,option4_img,option5_img]
        let plistFilePath = Bundle.main.path(forResource: "QuestionList", ofType: "plist")
        if FileManager.default.fileExists(atPath: plistFilePath!){
            let myDict = NSDictionary(contentsOfFile: plistFilePath!)
            //var dict:Dictionary = myDict?.object(forKey: 0) as! Dictionary<String,Any>
           // print(myDict!)
            questionList = myDict!.object(forKey: "Objects") as! [Dictionary<String,Any>]
            //print(arr[0]["question"])
        }
        
        //print(questionList)
        setQuestion()
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        option1.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        option2.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        option3.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        option4.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        option5.addGestureRecognizer(tap)

    }
    
    func setQuestion(){
        //print(qid)
        question_no.text = String(qid+1)
        questionLb.text = questionList[qid]["question"] as? String
        var dict = questionList[qid]["answers"] as? [String]
        
        option1_lb.text = dict?[0]
       // print(dict!)
        if qid > 7 {
            option2.isHidden = true
            option4.isHidden = true
            option3_lb.text = dict?[1]
            option5_lb.text = dict?[2]
        } else {
            option2.isHidden = false
            option4.isHidden = false
            option2_lb.text = dict?[1]
            option3_lb.text = dict?[2]
            option4_lb.text = dict?[3]
            option5_lb.text = dict?[4]
        }
        
        
    }
    
    //called when signup link is tapped
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let tag = sender.view?.tag
        //print(tag!)
      //  print(selectedTag)
        imgArr[(tag!-1)].image = UIImage(named: "check.png")
        
        if selectedTag > -1{
            imgArr[selectedTag-1].image = UIImage(named: "uncheck.png")
        }
        selectedTag = tag!
        
    }
    
    @IBAction func submitAns(_ sender: Any) {
        if selectedTag <= -1{
            showMsg(title: "", subTitle: "Please answer the question")
        } else {
        
        answers[qid] = selectedTag-1
        backBtn.isHidden = false
        if submitBtn.currentTitle == "Submit" {
            
            let arraySum = answers.reduce(0) { $0 + $1 }
           
            UserDefaults.standard.set(arraySum, forKey: "survey")
            
            //pass parameters to server
            let params = ["q1": (questionList[0]["question"] as? String)!,
                          "q1value": answers[0],
                          "q2": (questionList[1]["question"] as? String)!,
                          "q2value": answers[1],
                          "q3": (questionList[2]["question"] as? String)!,
                          "q3value": answers[2],
                          "q4": (questionList[3]["question"] as? String)!,
                          "q4value": answers[3],
                          "q5": (questionList[4]["question"] as? String)!,
                          "q5value": answers[4],
                          "q6": (questionList[5]["question"] as? String)!,
                          "q6value": answers[5],
                          "q7": (questionList[6]["question"] as? String)!,
                          "q7value": answers[6],
                          "q8": (questionList[7]["question"] as? String)!,
                          "q8value": answers[7],
                          "q9": (questionList[8]["question"] as? String)!,
                          "q9value": answers[8],
                          "q10": (questionList[9]["question"] as? String)!,
                          "q10value": answers[9],
                          "total":arraySum
                ] as [String : Any]
            //show loader
            SVProgressHUD.show()
            
            post_submitsurvey(parameters: params, handler: {(data) in
                //dismiss loader
                
                SVProgressHUD.dismiss()
                DispatchQueue.main.async(execute: {
                    let bundle = Bundle.main
                    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
                    
                    //redirect to profile page
                    let newViewController: ShowResultViewController = storyboard.instantiateViewController(withIdentifier: "ShowResultViewController") as! ShowResultViewController
                    newViewController.scores = arraySum
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                })
            })
            
            
        } else {
        
        
            if qid==8{
                //submitBtn.titleLabel?.text = "Submit"
                submitBtn .setTitle("Submit", for: UIControlState.normal)
                qid = qid + 1
            } else {
                if qid==0{
                    if selectedTag == 1{
                        qid = 8
                    } else {
                        qid = qid + 1
                    }
                } else if qid==2{
                    if (answers[1] + answers[2] == 0){
                        qid = 8
                    } else {
                        qid = qid + 1
                    }
                } else {
                    qid = qid + 1
                }
                
                
            }
            print("new question")
            if selectedTag > -1{
                imgArr[selectedTag-1].image = UIImage(named: "uncheck.png")
            }
            setQuestion()
        }
        selectedTag = -1
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        if qid==1 {
            backBtn.isHidden = true
            qid = qid - 1
        } else {
            backBtn.isHidden = false
            backBtn .setTitle("Back", for: UIControlState.normal)
            if qid==8{
                if answers[0]==0{
                    qid = 0
                    backBtn.isHidden = true
                } else if (answers[1] + answers[2] == 0){
                     qid = 2
                } else {
                    qid = qid - 1
                }
            } else {
                qid = qid - 1
            }
            
        }
        print("new back qid")
        print(qid)
        setQuestion()
        if selectedTag > -1{
            imgArr[selectedTag-1].image = UIImage(named: "uncheck.png")
        }
        imgArr[answers[qid]].image = UIImage(named: "check.png")
        selectedTag = answers[qid] + 1
    }
    
    func showMsg(title: String, subTitle: String) -> Void {
        let alertController = UIAlertController(title: title, message:
            subTitle, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
