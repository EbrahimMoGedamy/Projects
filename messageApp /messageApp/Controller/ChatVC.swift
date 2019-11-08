//
//  ChatVC.swift
//  messageApp
//
//  Created by Ebrahim Mo Gedamy on 7/17/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import Firebase


class ChatVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var messageTxtField: UITextField!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var chatTableView: UITableView!
    
    
    var chatMessage = [Message]()
    var room : Room?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.userNameLbl.text = room?.roomName
        chatTableView.tableFooterView = UIView()
        chatTableView.allowsSelection = false
        self.observeMessage()
        
    }
    
    
    func observeMessage(){
        
        guard let roomId = self.room?.roomId else { return  }
        
        let ref = Database.database().reference()
        ref.child("rooms").child(roomId).child("messages").observe(.childAdded) { (dataSnapshot) in
            print(dataSnapshot)
            if let dataArr = dataSnapshot.value as? [String : Any] {
                guard let senderName = dataArr["Sender"] as? String , let messageBody = dataArr["Message"]  as? String , let userId = dataArr["messageSender"] as? String  else{
                    return
                }
                let message = Message(messageKey: dataSnapshot.key, messageBody: messageBody, senderName: senderName, userId: userId)
                self.chatMessage.append(message)
                self.chatTableView.reloadData()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = self.chatMessage[indexPath.row]
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCellVC
        cell.setMessageData(message: message)
        if (message.userId == Auth.auth().currentUser!.uid){
            cell.setMessageType(type: .outgoing)
        }else{
            cell.setMessageType(type: .incoming)
        }
        return cell
    }
    
    
    
    @IBAction func backBu(_ sender: UIButton) {
        
        self.backToRoomVC()
    }
    
    func backToRoomVC( ){
        self.dismiss(animated: true, completion: nil)
        let roomVC = self.storyboard?.instantiateViewController(withIdentifier: "roomVC") as! RoomsVC
        
        self.navigationController?.pushViewController(roomVC, animated: true)
    }
    
    func getUsernameWithId(id : String , completion : @escaping (_ userName : String?)->() ) {
        let ref = Database.database().reference()
        let user = ref.child("users").child(id)
        user.child("userName").observeSingleEvent(of: .value) { (dataSnapshot) in
            if let userName = dataSnapshot.value as? String {
                completion(userName)
            }else{
                completion(nil)
            }
        }
    }
    
    func sendMessage(messageTxt : String , completion : @escaping (_ isSuccess : Bool)->() ) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        getUsernameWithId(id: userId) { (userName) in
            if let userName = userName {
                //print("userName : \(userName)")
                if let roomId = self.room?.roomId , let userId = Auth.auth().currentUser?.uid {
                    let dataArr : [String : String ] = ["Sender" : userName , "Message" : messageTxt , "messageSender" : userId]
                    let ref = Database.database().reference()
                    let room = ref.child("rooms").child(roomId)
                    room.child("messages").childByAutoId().setValue(dataArr, withCompletionBlock: { (error , ref) in
                        if error == nil {
                            completion(true)
                        }else{
                            completion(false)
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func sendBu(_ sender: UIButton) {
        let message = messageTxtField.text!
        if message.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "our dear user , you must type message ", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        sendMessage(messageTxt: message) { (success) in
            if success {
                self.messageTxtField.text = " "
                print("room added to database successfully")
            }else{
                print("Error 404")
            }
            
        }
    }
    
}
