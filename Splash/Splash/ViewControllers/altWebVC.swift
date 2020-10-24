//
//  altWebVC.swift
//  Splash
//
//  Created by Ben Lapidus on 12/4/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit
import WebKit

class altWebVC: UIViewController {
    var inputURL:String?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputURL = "https://www.fishwatch.gov/profiles/all-profiles"
        
        if let address = inputURL, let url = URL(string: address) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
