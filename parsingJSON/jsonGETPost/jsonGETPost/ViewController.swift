//
//  ViewController.swift
//  jsonGETPost
//
//  Created by Ebrahim  Mo Gedamy on 9/16/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func GetPressed(_ sender: UIButton) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            if let response = response {
                
                print("Response : ")
            }
            
            if let data = data  {
                print("Data : \(data)")
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [ ])
                    print("Json : \(json)")
                }catch{
                    print("Error : \(error)")
                }
            }
        }
        session.resume()
    }
    @IBAction func postPressed(_ sender: UIButton) {
        
        let parameters = ["userName" : "@ebrahiMoG" , "tweet" : "Hello everyone"]
         guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if response != nil {
                print("Response : ")
            }
            if let data = data {
                print("Data : \(data)")
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Json : \(String(describing: json))")
                }catch{
                    print("Error : \(error)")
                }
                
            }
        }
        session.resume()
    }
    
    
    @IBAction func sendMessagePost(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Message", message: "Enter New Message ", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Your Message..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) in
            guard let text = alert.textFields?.first?.text else {
                print("Not Text Avilable !")
                return
            }
            let message = Message(message: text)
            let postRequest = ApiRequest(endPoint: "messages")
            postRequest.saveMessage(message, completion: { result in
                
                switch result{
                case .success(let message ) :
                    print("The following message has been sent : \(message.message) ")
               
                case .failure(let error):
                    print("An erorr ocurred : \(error)")
                }
            })
        }))
        self.present(alert , animated: true)
    }
}

