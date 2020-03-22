//
//  Comment.swift
//  JSONDownloading
//
//  Created by Ebrahim  Mo Gedamy on 9/16/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation


struct CommentElement: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias Commentt = [CommentElement]
