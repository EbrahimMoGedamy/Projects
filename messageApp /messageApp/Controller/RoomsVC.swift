//
//  ChatVC.swift
//  messageApp
//
//  Created by Ebrahim  Mo Gedamy on 7/17/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import Firebase

class RoomsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var titleLabl: UILabel!
    @IBOutlet weak var roomsTable: UITableView!
    @IBOutlet weak var addBu: UIButton!
    @IBOutlet weak var rommTxtField: UITextField!
    
    var rooms = [Room]( )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting rid of extra empty cell in tableView
        roomsTable.tableFooterView = UIView( )
        self.observRoom()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check if user didLogin or not
        if (Auth.auth().currentUser == nil) {
            self.presentloginScreen()
        }
    }
    
    func observRoom()  {
        Database.database().reference().child("rooms").observe(.childAdded) { (dataSnapshot) in
            
            if let dataArr = dataSnapshot.value as? [String : Any] {
                if let roomName = dataArr["roomName" ] as? String  {
                    let room = Room.init(roomId: dataSnapshot.key, roomName: roomName)
                    self.rooms.append(room)
                    self.roomsTable.reloadData()
                    
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRoom = self.rooms[indexPath.row]
        let chatVC = self.storyboard?.instantiateViewController(withIdentifier: "chatVC") as! ChatVC
        chatVC.room = selectedRoom
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let room = self.rooms[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomsCell", for: indexPath)
        cell.textLabel?.text = room.roomName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            rooms.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        self.roomsTable.dataSource = self
        self.roomsTable.reloadData()
    }
   
    
    @IBAction func logOutBu(_ sender: UIButton) {
        
        try! Auth.auth().signOut()
        self.presentloginScreen()
        
    }
    
    func presentloginScreen() {
        //  init loginRegister screen
        let signInUp = self.storyboard?.instantiateViewController(withIdentifier: "signUpInScreen") as! StartVC
        self.present(signInUp, animated: true, completion: nil)
    }
    
    @IBAction func addBuPressed(_ sender: UIButton) {
        guard let newRoom = self.rommTxtField.text , newRoom.isEmpty == false  else {
            return
        }
        let dataArray : [ String : String] = ["roomName" : newRoom]
        let databaseRef = Database.database().reference()
        let room = databaseRef.child("rooms").childByAutoId()
        room.setValue(dataArray) { (error, ref) in
            if error == nil {
                
                self.rommTxtField.text = " "
            }else{
                
            }
        }
    }
    

}
