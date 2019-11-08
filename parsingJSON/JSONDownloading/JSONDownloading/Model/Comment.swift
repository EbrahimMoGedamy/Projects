//
//  Comment.swift
//  JSONDownloading
//
//  Created by Ebrahim  Mo Gedamy on 9/16/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation

class Comments : Codable {
    let coments : [Comment]
    
    init(comments : [Comment] ) {
        self.coments = comments
    }
}

class Comment : Codable {
    
    let postId : String?
    let id : Int?
    let name : String?
    let email : String?
    let body : String?
    
    
    
    init(postId : String , id : Int , name : String , email : String , body : String) {
        
        self.body = body
        self.email = email
        self.id = id
        self.name = name
        self.postId = postId
    }
    
    
}
