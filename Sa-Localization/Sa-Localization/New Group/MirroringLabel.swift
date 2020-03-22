//  Localizer.swift
//  Tarleem
//
//  Created by Khaled on 5/1/17.
//  Copyright © 2017 khalid. All rights reserved.
//


import UIKit

class MirroringLabel: UILabel {
    override func layoutSubviews() {
            if Language.currentLanguage() == "ar"  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
    }
}
