//
//  ProductsCell.swift
//  swageApp
//
//  Created by Ebrahim  on 6/23/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import UIKit

class ProductsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageNameC: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func updateproducts(products : Product) {
        imageNameC.image = UIImage(named: products.imageName)
        descriptionLabel.text = products.title
        priceLabel.text = products.price
        
    }
}
 
