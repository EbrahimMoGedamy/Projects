//
//  ViewController.swift
//  noteApp
//
//  Created by Ebrahim  Mo Gedamy on 7/23/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class AddNotesVC: UIViewController {

    
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var details: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveNoteBu(_ sender: UIButton) {
        let myNotes = MyNotes(context: context)
        myNotes.details = details.text
        myNotes.savedDate = NSDate() as Date
        myNotes.title = noteTF.text
        
        do {
            // to save these data
            appDelegate.saveContext()
            print("StoreName Saved")
            details.text = " "
            noteTF.text = " " 
        } catch {
            print("Error")
        }
        
        
        
        
    }
    @IBAction func showMyNotes(_ sender: UIBarButtonItem) {
  self.presentNoteListScreen()
        
        
    }
    func presentNoteListScreen() {
        
        let noteListVC = self.storyboard?.instantiateViewController(withIdentifier: "noteListVC") as!  NoteListVC
        self.present(noteListVC, animated: true, completion: nil)
        
    }

    
}

