//
//  DetailViewController.swift
//  Project16
//
//  Created by Ceboolion on 20/05/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url: String = ""

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openPage()
    }
    
    func openPage(){
        guard let safeUrl = URL(string: url) else {return}
        webView.load(URLRequest(url: safeUrl))
    }
}
