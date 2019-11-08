//
//  AddItemsVC.swift
//  StoreApp
//
//  Created by Ebrahim  Mo Gedamy on 7/24/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import CoreData
class AddItemsVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemsPKV: UIPickerView!
    @IBOutlet weak var imageItem: UIImageView!
    
    var storeTypeArr = [StoreType]( )
    var editDeletObj : Items?
    
    // imagePicker to select image from Photos App when press on the button that is above an image in UI
    var imagePicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController( )
        imagePicker.delegate = self
        
        if editDeletObj != nil {
            self.loadForEdit()
        }
        self.loadStors()
        
    }
    
    func loadForEdit(){
        if let item = editDeletObj{
            itemName.text = item.name
            imageItem.image = item.image as! UIImage
            if let store = item.toStore{
                var index = 0
                while index < storeTypeArr.count{
                    let row = storeTypeArr[index]
                    if row.name == store.name {
                        itemsPKV.selectRow(index, inComponent: 0, animated: true)
                    }
                    index += 1
                }
            }
        }
       
    }
    
    func loadStors() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoreType")
        
        do{
            storeTypeArr = try context.fetch(fetchRequest) as! [StoreType]
            
        }catch  {
            print("Fetch Error")
        }
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return storeTypeArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = storeTypeArr[row]
        return store.name
    }
    
    //to implement imagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageItem.image = image
        }
        // self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedImageBu(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveBu(_ sender: UIButton) {
        let newItem : Items!
        if editDeletObj == nil {
            newItem = Items(context: context)
        }else{
            newItem = editDeletObj
        }
        newItem.name = itemName.text
        newItem.image = imageItem.image
        newItem.addedDataDate = NSDate( ) as Date
        newItem.toStore = storeTypeArr[itemsPKV.selectedRow(inComponent: 0)]
        
        do{
            appDelegate.saveContext()
            itemName.text = " "
            itemName.placeholder = "type item name"
            print("Successfully , newItem is saved")
        }catch{
            print("Error : newItem not saved")
        }
    }
    
    @IBAction func addStoreBu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toAddStore", sender: nil)
    }
    
    @IBAction func backBu(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func trashBu(_ sender: UIButton) {
       
        if editDeletObj != nil {
            context.delete(editDeletObj!)
            appDelegate.saveContext()
           _ = navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
    }
}
}
