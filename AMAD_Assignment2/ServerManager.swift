//
//  ServerManager.swift
//  MAD_Assignment1
//
//  Created by Pranalee Jadhav on 8/28/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import Foundation
import Alamofire

//check internet connectivity
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

//to call register api
func post_registerrequest(parameters: Parameters, handler:@escaping (Int) -> Void) -> Void {
    if Connectivity.isConnectedToInternet {
        let server_url = "http://laravel-jwt.us-east-2.elasticbeanstalk.com/api/register"
        
        Alamofire.request(server_url, method: .post, parameters: parameters,encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch response.result {
                case .success(let value):
                    print("response")
                    print(value)
                    if let dict = value as? Dictionary<String, Any>{
                       
                        if let val = dict["token"]{
                            
                            UserDefaults.standard.set(val, forKey: "token")
                            handler(2)
                        } else {
                           
                            handler(3)
                        }
                        
                    } else {
                        handler(3)
                    }
                    
                    
                    break
                    
                case .failure(let error):
                    print(error)
                    handler(1)
                    
                }
        }
        
        
    }
    else {
        handler(0)
    }
}

//to call login api
func post_loginrequest(parameters: Parameters, handler:@escaping (Int) -> Void) -> Void {
   if Connectivity.isConnectedToInternet {
      
       let server_url = "http://laravel-jwt.us-east-2.elasticbeanstalk.com/api/login"
        
         Alamofire.request(server_url, method: .post, parameters: parameters,encoding:
         JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
        
         switch response.result {
         case .success(let value):
            print("response")
            if let dict = value as? Dictionary<String, String>{
                //print(dict["token"]!)
                if let val = dict["token"]{
                    print(val)
                    UserDefaults.standard.set(val, forKey: "token")
                    handler(2)
                } else {
                    
                    handler(3)
                }
                
            }
            
           
         break
         
         case .failure(let error):
         print(error)
             handler(1)
            
         }
         }
       
        
}
    else {
        handler(0)
    }
}

//to call update profile api
func post_updateprofilerequest(parameters: Parameters, handler:@escaping (Int) -> Void) -> Void {
    if Connectivity.isConnectedToInternet {
        let server_url = "http://laravel-jwt.us-east-2.elasticbeanstalk.com/api/updatedata"
        
        Alamofire.request(server_url, method: .post, parameters: parameters,encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                print(response)
                switch response.result {
                case .success(let value):
                    if let dict = value as? Dictionary<String, Any>{
                        //print(dict["token"]!)
                        if let val = dict["success"] as? Bool{
                            if(val){
                                handler(2)
                            } else {
                                handler(3)
                            }
                        }
                        
                    }
                    break
                    
                case .failure(let error):
                    print(error)
                    handler(1)
                }
        }
    }else {
        handler(0)
    }
}

//to call get profiledata api
func post_showprofilerequest(parameters: Parameters, handler:@escaping (Dictionary<String, Any>) -> Void) -> Void {
    if Connectivity.isConnectedToInternet {
        let server_url = "http://laravel-jwt.us-east-2.elasticbeanstalk.com/api/user?token="+UserDefaults.standard.string(forKey: "token")!
        
        Alamofire.request(server_url).responseJSON { (response:DataResponse<Any>) in
                print(response)
                switch response.result {
                case .success(let value):
                    if let val = value as? Dictionary<String, Any> {
                       
                    if let dict = val["user"] as? Dictionary<String, Any>{
                        handler(dict)
                    } else {
                        handler(["code":1])
                    }
                    }else {
                        handler(["code":1])
                    }
                    break
                    
                case .failure(let error):
                    print(error)
                    handler(["code":1])
                }
        }
    }else {
        handler(["code":"0"])
    }
}

//to call logout api
func post_logoutrequest(parameters: Parameters, handler:@escaping (Int) -> Void) -> Void {
    
    if Connectivity.isConnectedToInternet {
        
        
        let server_url = "http://laravel-jwt.us-east-2.elasticbeanstalk.com/api/logout?token="+UserDefaults.standard.string(forKey: "token")!
        Alamofire.request(server_url)
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success(let value):
                    print("response")
                    if let dict = value as? Dictionary<String, Any>{
                        if let val = dict["success"] as? Bool{
                            if(val){
                                handler(2)
                            } else {
                                handler(3)
                            }
                        }
                        
                    }
                    
                    
                    break
                    
                case .failure(let error):
                    print(error)
                    handler(1)
                    
                }
        }
        
    }
}


