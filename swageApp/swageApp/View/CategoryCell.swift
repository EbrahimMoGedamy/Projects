//
//  CategoryCell.swift
//  swageApp
//
//  Created by Ebrahim  on 6/22/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var imageName: UIImageView!
 

   func update(category:Category)  {
        imageName.image = UIImage(named: category.imageName)
        lableName.text = category.title
    
    
    }
    
}
