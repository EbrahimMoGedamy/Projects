//
//  Api+Tasks.swift
//  webServicesDemo
//
//  Created by Ebrahim  Mo Gedamy on 7/20/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension Api {
    
    class func tasks(completion : @escaping (_ error : Error? , _ tasks : [Task]?)->Void){
        
        let url = URLs.tasks
        
        guard let apiToken = Helper.getApiToken() else {
            completion(nil, nil)
            return
        }
        
        let params = ["apiToken" : apiToken]
        
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            switch response.result {
            case .failure(let error):
                completion(error , nil)
                print(error)
                
                //////////////////////////////////////////////////////////////////
                
            case .success(let value):
                print("Success! Got the weather data")
                let json = JSON(value)
                guard let dataArr = json["data"].array else {
                    completion(nil , nil)
                    return
                }
                
                var tasks = [Task]( )
                for data in dataArr {
                    
                    guard let data = data.dictionary else {return}
                    
                    let task = Task( )
                    task.id = data["id"]?.int ?? 0
                    task.completed = data["completed"]?.bool ?? false
                    task.task = data["task"]?.string ?? " "
                    
                    tasks.append(task)
                }
                completion(nil , tasks)
            }
        }
        
    }
}




