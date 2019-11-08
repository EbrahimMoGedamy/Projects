//
//  Config.swift
//  webServicesDemo
//
//  Created by Ebrahim  Mo Gedamy on 7/19/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import Foundation

struct URLs {
    static let mainUrl = "https://127.0.0.1:8000/api/v1/"
    
    // Post{email , password}
    static let login = mainUrl + "login"
    
    // Post{ name , email , password , password-confirm}
    static let register = mainUrl + "register"
    
    //Get {api_token , page , per_page}
    static let tasks = mainUrl + "tasks"
    
}
