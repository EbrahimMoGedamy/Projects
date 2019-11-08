//
//  ChatVC.swift
//  chatApp
//
//  Created by Ebrahim  on 6/24/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatVC: UIViewController , UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate{
  


//@IBOutlet var heightConstraints: NSLayoutConstraint!
@IBOutlet var senderBU : UIButton!
@IBOutlet weak var chatTableView: UITableView!
@IBOutlet weak var messageTextfield: UITextField!
 
    //var arrOfMessages = [" First Message"," Second Message"," Third  Message","Fourth Message"," Fifth Message"]
    var arrRetrivedMessages : [Message] = [Message ]( )
    override func viewDidLoad() {
        super.viewDidLoad()

       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        chatTableView.addGestureRecognizer(tapGesture)
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil) , forCellReuseIdentifier: "customMessageCell")
        configureTableView( )
        messageTextfield.delegate = self
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        retrivedMessages()
        chatTableView.separatorStyle = .none
    }
    
   func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    
     messageTextfield = textField

  }
    
    @objc func tableViewTapped( ){
        messageTextfield.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRetrivedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell",for: indexPath) as! CustomMessageCell
        
       cell.messageBody.text = arrRetrivedMessages[indexPath.row ].messageBody
       cell.senderUsername.text = arrRetrivedMessages[indexPath.row].messageSender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String?{
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
        }else{
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.flatGray()
            
        }
      return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextfield.resignFirstResponder()
        return true
    }
    
    func configureTableView( ){
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 120.0
    }
    @IBAction func sendBu(_ sender: UIButton) {
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        senderBU.isEnabled  = false
       
        let messageDatabase = Database.database().reference().child("Messages")
        let messageDictionary = [ "Sender" : Auth.auth().currentUser?.email , "messageBody" : messageTextfield.text!]
        
        messageDatabase.childByAutoId().setValue(messageDictionary){
            ( error ,reference) in
                if error != nil{
                    print(" (ERROR : \(error!)")
                }else{
                    print(" message saved successfully ")
                    self.messageTextfield.isEnabled = true
                    self.senderBU.isEnabled  = true
                    self.messageTextfield.text = ""
            }
        }
        
    }
    
    func retrivedMessages( ){
        let messageDatabase = Database.database().reference().child("Messages")
        // to make firebase listen to newAddedMessages
        messageDatabase.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String , String >
            let sender = snapshotValue["Sender"]
            let message = snapshotValue["messageBody"]
            //print("message : \(message!)\nsender : \(sender!)")
            let messageObj = Message( )
            messageObj.messageBody = message ?? ""
            messageObj.messageSender = sender ?? ""
            self.arrRetrivedMessages.append(messageObj)
            self.configureTableView()
            self.chatTableView.reloadData()
            
        }
        
    }
    @IBAction func logOutBu(_ sender: UIBarButtonItem) {
        do{
      try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("error , there is aproblem in signing out")
        }
    
    }
}
