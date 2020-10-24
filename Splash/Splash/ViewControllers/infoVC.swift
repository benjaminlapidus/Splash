//
//  infoVC.swift
//  Splash
//
//  Created by Ben Lapidus on 12/2/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit
import WebKit

protocol DetailViewDelegate: class {
    func updateItems()
}

class infoVC: UIViewController, UINavigationControllerDelegate {
    var inputURL:String?
    var fish: Fish?
    weak var delegate: DetailViewDelegate?
    var fishName:String = "all-profiles"

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputURL = "https://www.fishwatch.gov/profiles/"
        

        if let name = fish?.name {
            fishName = name
        }
        
        fishName = fishName.replacingOccurrences(of: " ", with: "-", options: .literal, range: nil)
        fishName = fishName.lowercased()
        inputURL?.append(fishName)
        
        if let address = inputURL, let url = URL(string: address) {
            let request = URLRequest(url: url)
            webView.load(request)
        }

    }
}
