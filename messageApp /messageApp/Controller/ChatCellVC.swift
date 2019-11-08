//
//  ChatCellVC.swift
//  messageApp
//
//  Created by Ebrahim  Mo Gedamy on 8/3/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class ChatCellVC: UITableViewCell {
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageBody: UITextView!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var chatStack: UIStackView!
    
    enum MessageType {
        case incoming
        case outgoing
    }
    
    override func awakeFromNib() {
        messageContainer.layer.cornerRadius = 6.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 5, right: 2))
    }
    
    func setMessageData(message : Message) {
        userNameLbl.text = message.senderName
        messageBody.text = message.messageBody
    }
    
    func setMessageType(type : MessageType) {
      
        if (type == .incoming) {
            chatStack.alignment = .leading
            messageContainer.backgroundColor = #colorLiteral(red: 0.9518675086, green: 1, blue: 1, alpha: 1)
        }else if (type == .outgoing){
            chatStack.alignment = .trailing
            messageContainer.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
}
