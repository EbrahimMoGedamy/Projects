//
//  ViewController.swift
//  webKitDemo
//
//  Created by Ebrahim  Mo Gedamy on 10/25/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController , UITextFieldDelegate , WKNavigationDelegate{
    
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var forwardBu: UIButton!
    @IBOutlet weak var backBu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchTxtField.delegate = self
        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        let urlString = self.searchTxtField.text
        let url = URL(string: urlString!)
        let urlRequest = URLRequest(url: url!)
         webView.load(urlRequest)
        self.searchTxtField.resignFirstResponder() // to dismiss keyboard
        
        return true
        
    }
    
    @IBAction func frowardBuTapped(_ sender: UIButton) {
        
        if webView.canGoForward {
            webView.goForward()
        }
        
    }
    @IBAction func backButapped(_ sender: UIButton) {
        
        if webView.canGoBack {
            webView.goBack()
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backBu.isEnabled = webView.canGoBack
        forwardBu.isEnabled = webView.canGoForward
        searchTxtField.text = webView.url?.absoluteString
        
    }
    
}

