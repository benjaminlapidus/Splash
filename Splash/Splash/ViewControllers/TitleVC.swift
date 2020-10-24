//
//  TitleVC.swift
//  Splash
//
//  Created by Ben Lapidus on 11/23/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class TitleVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var startButton: UIButton!

    @IBOutlet weak var catchLog: UIButton!
    
    @IBOutlet weak var catchesContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.setTitle(NSLocalizedString("startButton", comment: ""), for: .normal)
        
        catchLog.setTitle(NSLocalizedString("catchLog", comment: ""), for: .normal)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(home), name: NSNotification.Name(rawValue: "home"), object: nil)
        catchesContainer.isHidden = true

        launchAnimations()
        

        // Do any additional setup after loading the view.
    }
    
    @objc func home(){
        UIView.transition(with: self.mainView, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.catchesContainer.isHidden = true
        }, completion: nil)
        
    }
    
    
    @IBAction func onStartButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.mainView.alpha = 0.0
        }, completion: { _ in
            self.performSegue(withIdentifier: "toGameView1", sender: nil)
        })
    }
    
    @IBAction func onCatchesButton(_ sender: UIButton) {
        if (UIScreen.main.nativeBounds.height >= 2688){
            UIView.transition(with: self.mainView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.catchesContainer.isHidden = false
            }, completion: nil)
        } else {
            performSegue(withIdentifier: "toSmallScreen", sender: nil)
        }
    }
    
    @IBAction func onSettingsButton(_ sender: UIButton) {
        

    }
    
    func launchAnimations(){

    }

}
