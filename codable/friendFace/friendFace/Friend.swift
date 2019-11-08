//
//  Friend.swift
//  friendFace
//
//  Created by Ebrahim Mo Gedamy on 7/10/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation

struct Friend : Codable {
    let id : UUID?
    let isActive : Bool?
    let name : String?
    let age : Int?
    let company : String?
    let email : String?
    let address : String?
    let About : String?
    let registeration : Date?
    let tags : [String]?
    let friends : [Connection]
    
}
