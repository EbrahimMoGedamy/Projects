//
//  Hero.swift
//  codableDemo
//
//  Created by Ebrahim  Mo Gedamy on 7/12/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation

struct Hero : Codable {
    
    let name:String?
    let realname: String?
    let team: String?
    let firstappearance: String?
    let createdby: String?
    let publisher: String?
    let imageurl: String?
    let bio: String?
    

}

let hero = Hero(name: "", realname: "", team: "", firstappearance: "", createdby: "", publisher: "", imageurl: "", bio: "")
