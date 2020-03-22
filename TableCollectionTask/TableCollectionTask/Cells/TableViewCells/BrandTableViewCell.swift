//
//  BannerTableViewCell.swift
//  TableCollectionTask
//
//  Created by Mohamed Gebril on 4/21/19.
//  Copyright © 2019 beescell. All rights reserved.
//

import UIKit

class BrandTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    

    @IBOutlet var categoryLabel:UILabel!
    @IBOutlet var categoryCollectionView:UICollectionView!
    
    var contentArr:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath
            ) as! ProductsCollectionViewCell
        
        cell.productImageView.image = UIImage(named: contentArr[indexPath.item])
        
        return cell
        
    }
    
    

}
