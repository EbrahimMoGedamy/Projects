//
//  ViewController.swift
//  JSONDownloading
//
//  Created by Ebrahim  Mo Gedamy on 9/16/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    final let url = URL(string: "https://jsonplaceholder.typicode.com/comments")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.downloadJson()
    }


    
    func downloadJson()  {
        
        guard let url = url else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            guard let data = data , error == nil , response != nil else {
                print("SomeThing Go Wrong")
                return
            }
             print("downloaded")
            do{
                let decoder = JSONDecoder()
                let comment = try decoder.decode(Comment.self, from: data)
                print(comment)
            }catch{
                print("SomeThing Go Wrong Aftar Downloading")
            }
            
        }.resume()
    }
}

