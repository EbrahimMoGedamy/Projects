//
//  Api.swift
//  webServicesDemo
//
//  Created by Ebrahim  Mo Gedamy on 7/19/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Api: NSObject {
    
    class func login(email : String , password : String , completion : @escaping ( _ error : Error? , _ success : Bool )->Void){
        
        let url = URLs.login
        let paramters = ["email :" : email , "password :" : password]
        
        Alamofire.request(url, method: .post, parameters: paramters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 100..<200)
            .responseJSON { (response) in
                switch response.result{
                case .failure(let error):
                    completion(error , false)
                    print("It not work!")
                    print(error)
                case .success(let value):
                    completion(nil , true)
                    print("It worked!")
                    let json = JSON(value)
                    if let apiToken = json["user"]["api_token"].string{
                        print("apiToken : \(apiToken)")
                        
                        // save api_token to keep deafult user
                         Helper.saveApiToken(token: apiToken)
                    }
                    print(value)
                }
        }
    }
    
    
    class func register( name : String , email : String , password : String , completion : @escaping ( _ error : Error? , _ success : Bool )->Void){
        
        let url =  URLs.register
        let paramters = [ "name : " : name , "email :" : email , "password :" : password , "password_confirmation : " : password]
        
        Alamofire.request(url, method: .post, parameters: paramters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 100..<200)
            .responseJSON { (response) in
                switch response.result{
                case .failure(let error):
                    completion(error , false)
                    print("It not work!")
                    print(error)
                case .success(let value):
                    completion(nil , true)
                    print("It worked!")
                    let json = JSON(value)
                    if let apiToken = json["user"]["api_token"].string{
                        print("apiToken : \(apiToken)")
                        
                        // save api_token to keep deafult user
                        Helper.saveApiToken(token: apiToken)
                    }
                    print(value)
                }
        }
    }

}
