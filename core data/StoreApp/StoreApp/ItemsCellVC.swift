//
//  ItemsCell.swift
//  StoreApp
//
//  Created by Ebrahim  Mo Gedamy on 7/24/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class ItemsCellVC: UITableViewCell {

    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDate: UILabel!
    @IBOutlet weak var itemName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setCell(item : Items) {
    
        storeName.text = item.name
        itemImage.image = item.image as? UIImage
        itemName.text = item.toStore?.name
        
        // convert date to string
        let dateFormatter = DateFormatter( )
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        itemDate.text = dateFormatter.string(from: item.addedDataDate as! Date)
        
        
    }

}
