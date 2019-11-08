//
//  ProductsVC.swift
//  swageApp
//
//  Created by Ebrahim  on 6/23/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import UIKit

class ProductsVC: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource{
   
    @IBOutlet weak var productsCollectionView: UICollectionView!
   
     public var products = [Product]( )
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    func initProducts(category:Category){
       products = DataServices.instanceOfData.getProducts(forCategoryTitle: category.title)
        navigationItem.title = category.title
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductsCell{
            let product = products[indexPath.row]
            
            cell.updateproducts(products: product)
             return cell
        }
        return ProductsCell()
       
        
        
    }
}



