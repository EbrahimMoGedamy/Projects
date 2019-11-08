//
//  Category.swift
//  swageApp
//
//  Created by Ebrahim  on 6/22/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import Foundation

struct Category {
    private(set) public var title : String
    private(set) public var imageName : String
    init(title:String,imageName:String) {
        self.imageName = imageName
        self.title = title
    }
    
}
