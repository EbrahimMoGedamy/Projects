//
//  BannerTableViewCell.swift
//  TableCollectionTask
//
//  Created by Mohamed Gebril on 4/21/19.
//  Copyright © 2019 beescell. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet var bannerLabel : UILabel!
    @IBOutlet var bannerImageView : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
