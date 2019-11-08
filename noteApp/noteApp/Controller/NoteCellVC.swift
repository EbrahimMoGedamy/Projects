//
//  NoteCellVC.swift
//  noteApp
//
//  Created by Ebrahim  Mo Gedamy on 7/24/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class NoteCellVC: UITableViewCell {

    @IBOutlet weak var detailsCell: UITextView!
    @IBOutlet weak var titleCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(note : MyNotes) {
        
        detailsCell.text = note.details
        titleCell.text = note.title
    }

}
