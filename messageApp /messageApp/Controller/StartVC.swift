//
//  ViewController.swift
//  messageApp
//
//  Created by Ebrahim Mo Gedamy on 7/14/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import Firebase
import Photos

class StartVC: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextFieldDelegate , UIPickerViewDelegate , UIPickerViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
   
    let dataArray : [ String : Any] = [" ": (Any).self]
    let formCell = FormCell( )
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageProfile: UIImageView!
    
    
    
    // imagePicker to select image from Photos App when press on the button that is above an image in UI
    var imagePicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker = UIImagePickerController( )
        imagePicker.delegate = self
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
  }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        formCell.emailTxtField.resignFirstResponder()
        formCell.passwordTxtField.resignFirstResponder()
        formCell.userNameTxtField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! FormCell
        
        if (indexPath.row == 0) { // login cell
            cell.userNameContainer.isHidden = true
            cell.login.setTitle("Login", for: .normal)
            cell.register.setTitle("Register 👉🏼", for: .normal)
            cell.register.addTarget(self, action: #selector(slideToLoginCell(_:)), for: .touchUpInside)
            cell.login.addTarget(self, action: #selector(loginBuPressed(_:)), for: .touchUpInside)
            
        }else if (indexPath.row == 1) {// register cell
            cell.userNameContainer.isHidden = false
            cell.login.setTitle("Register ", for: .normal)
            cell.register.setTitle("👈 Login ", for: .normal)
            cell.register.addTarget(self, action: #selector(slideToRegisterCell(_:)), for: .touchUpInside)
            cell.register.addTarget(self, action: #selector(registerBuPressed(_:)), for: .touchUpInside)
        }else{
            
        }
        
        return cell
    }
    
    @objc func registerBuPressed( _ sender : UIButton) {
        let index = IndexPath(row: 1, section: 0)
        let cell = self.collectionView.cellForItem(at: index) as! FormCell
        
        guard let email = cell.emailTxtField.text , let password = cell.passwordTxtField.text else {
            return
        }
        if (email.isEmpty == true && password.isEmpty == true ) {
            self.displayErrors(errorTxt: "theses fields are required")
        }else{
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil{
                print(" (Error : \(error!)")
            }else{
                
                guard let userId = result?.user.uid , let userName = cell.userNameTxtField.text else {
                    return
                }
                self.dismiss(animated: true, completion: nil)
                
                let dataArray : [String : Any] = ["userName" : userName]
                let refrence = Database.database().reference()
                let user = refrence.child("users").child(userId)
                user.setValue(dataArray)
                
                
                print(" you signedUp successfully ")
                print("Your E-mail : \(result!.user.email!)")
                
            }
          }
        }
    }
    
    
    @objc func loginBuPressed( _ sender : UIButton) {
        let index = IndexPath(row: 0, section: 0)
        let cell = self.collectionView.cellForItem(at: index) as! FormCell
        
        guard let email = cell.emailTxtField.text , let password = cell.passwordTxtField.text else {
            return
        }
        
        if (email.isEmpty == true || password.isEmpty == true) {
            self.displayErrors(errorTxt: "theses fields are required")
        }else{
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil{
                    print(" (Error : \(error!)")
                    let alert = UIAlertController(title: "Error", message: "wrong userName or password" , preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: {
                      cell.emailTxtField.text = " "
                      cell.passwordTxtField.text = " "
                    })
                    
                }else{
                    print(" you signedIn successfully with E-mail : \(result!.user.email!) \n userName : \(String(describing: (Auth.auth().currentUser?.displayName)))")
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    let cell = FormCell()
    func displayErrors(errorTxt : String) {
        
        let alert = UIAlertController(title: "Error", message: errorTxt, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil
            //{
            //                self.cell.emailTxtField.text = " "
            //                self.cell.passwordTxtField.text = " "
            //}
            
        )
        
        
    }
    
    @objc func slideToLoginCell(_ sender : UIButton){
        
        let index = IndexPath(row: 1, section: 0)
        
        self.collectionView.scrollToItem(at: index, at: [.centeredHorizontally], animated: true)
    }
    
    @objc func slideToRegisterCell(_ sender : UIButton){
        
        let index = IndexPath(row: 0, section: 0)
        
        self.collectionView.scrollToItem(at: index, at: [.centeredHorizontally], animated: true)
    }
    
    
    
    // to change the size of collectionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    //to implement imagePicker
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            imageProfile.image = image
//        }
//        // self.dismiss(animated: true, completion: nil)
//    }
    
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//        self.dismiss(animated: true, completion: { () -> Void in
//
//        })
//
//        imageProfile.image = image
//    }
    @IBAction func selectImagProfile(_ sender: UIButton) {
        
        self.selectPhotoFromGallery()
    }
    
    func selectPhotoFromGallery() {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageProfile.contentMode = .scaleAspectFit
            self.imageProfile.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        print("cancel is clicked")
    }
    
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    
}


