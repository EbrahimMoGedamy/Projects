//
//  String.swift
//  webServicesDemo
//
//  Created by Ebrahim  Mo Gedamy on 7/19/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import Foundation

extension String{
    var trimmed : String {
      return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
