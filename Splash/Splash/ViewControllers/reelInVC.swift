
//
//  reelInVC.swift
//  Splash
//
//  Created by Ben Lapidus on 11/30/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class reelInVC: UIViewController {
    
    var progress: Float = 0.0
    var count:Int = 10
    var isCounting = false
    var timer:Timer!
    
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timeDisplay: UIButton!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapLabel.text = NSLocalizedString("tapToReel", comment: "")
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        configureData()
        configureProgressView()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timeDisplay.setTitle(String(count), for: .normal)
    }
    
    @objc func loadList(notification: NSNotification){
        isCounting = true
    }
    
    @IBAction func onTap(_ sender: Any) {
        addProgress()
    }
    
    func configureProgressView(){
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 10)
        progressView.setProgress(progress, animated: true)
        progressView.layer.cornerRadius = 20
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 20
        progressView.subviews[1].clipsToBounds = true
    }
    
    func configureData(){
        let defaults = UserDefaults.standard
        let fishSize = defaults.string(forKey: "Size")
        switch (fishSize!){
            case "Hard":
                self.count = 10
            case "Medium":
                self.count = 15
            case "Easy":
                self.count = 20
            default:
                self.count = 10
        }
    }
    
    @objc func fireTimer() {
        if (isCounting) {
            count -= 1
            timeDisplay.setTitle(String(count), for: .normal)
            if (count == 5){
                progressView.progressTintColor = .yellow
            }
            else if (count == 2){
                progressView.progressTintColor = .orange
            }
            else if (count == 0){
                timer.invalidate()
                isCounting = false
                progressView.progressTintColor = .red
                tapGesture.isEnabled = false
                count = 10
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fail"), object: nil)
            }
        }
    }
    
    func addProgress(){
        progress = progress + 0.02
        progressView.setProgress(progress, animated: true)
        if (progressView.progress >= 1.0){
            timer.invalidate()
            isCounting = false
            progressView.progressTintColor = .green
            tapGesture.isEnabled = false
            count = 10
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "success"), object: nil)
        }
    }
}
