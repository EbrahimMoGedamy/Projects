//
//  User.swift
//  userprofileeditor
//
//  Created by Ahmed Adel on 9/16/17.
//
//

import Foundation
import UIKit

/**
 User is the basic model object used by the Interactor.
 **/

class User{
    
    var name:String?
    var email:String?
    var country:String??
    var age:Int?
    var gender:Gender?
    var showProfileName:Bool?
    
    convenience init(name:String!, email:String!, country:String!, age:Int!, gender:Gender!,
                     showProfileName:Bool!){
        self.init()
        self.name = name
        self.email = email
        self.country = country
        self.age = age
        self.gender = gender
        self.showProfileName = showProfileName
    }
    
}
