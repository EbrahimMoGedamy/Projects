//
//  CustomeMessageCell.swift
//  chatApp
//
//  Created by Ebrahim  on 6/24/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {
    
    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    
}
