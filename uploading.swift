//
//  uploading.swift
//  AsiaSpa
//
//  Created by Ebrahim  Mo Gedamy on 11/15/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

git push -u origin master

import Foundation

import UIKit

class AdvImage {
    
    var img : UIImage
    var imgData : Data?
   
    
    init(img: UIImage, imgData: Data?) {
        
        self.img = img
        self.imgData = imgData
        
    }
}

let imagePickerController = UIImagePickerController()
imagePickerController.delegate = self
//        imagePickerController.view.tag = 1
let actionSheet = UIAlertController(title: "Photos", message: "choose a sourse", preferredStyle: .actionSheet)
actionSheet.addAction(UIAlertAction(title: "photoLibrary", style: .default, handler: { (action:UIAlertAction) in
    imagePickerController.sourceType = .photoLibrary
    imagePickerController.allowsEditing = true
    self.present(imagePickerController, animated: true, completion: nil)
}))

actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (nil) in
    
}))

self.present(actionSheet, animated: true, completion: nil)
var imagesData = [Data]()
var imagesKeys = [String]()

for i in images {
    
    imagesData.append(i.imgData!)
    imagesKeys.append("avatar")
}

extension EditProductVC: UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            let imageData:Data = (image).jpegData(compressionQuality: 0.75)! as Data
            self.images.append(AdvImage(img: image, imgData: imageData, id: 0))
            collectionProductImage.reloadData()

            print("images: \(images.count)")
            print("gggggg = \(images)")
            picker.dismiss(animated: true, completion: nil)
            
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let pic = image.jpegData(compressionQuality: 0.75)
            
            self.images.append(AdvImage(img: image, imgData: pic!, id: 0))
            print("images: \(images.count)")
            collectionProductImage.reloadData()

            picker.dismiss(animated: true, completion: nil)
            
        }
    }
}
