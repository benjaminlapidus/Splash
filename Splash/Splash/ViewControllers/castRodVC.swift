//
//  castRodVC.swift
//  Splash
//
//  Created by Ben Lapidus on 11/24/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class castRodVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    
    var isCaught = 0
    
    var fish = caughtFish()
    var currFishName:String = ""
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    
    var imageViewBackground: UIImageView = UIImageView(image: UIImage(named:"lakeBackground"))
    var rodDisplay: UIImageView = UIImageView(image: UIImage(named:"lakeBackground"))
    
    override func viewDidLoad() {



        super.viewDidLoad()
        homeButton.isEnabled = true
        rodDisplay = UIImageView(frame: CGRect(x: 0, y: height/5, width: width/3, height: height-100))
        imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        configureView()


        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {

            switch (self.isCaught){
            case 1:
                self.gotAwayAlert()
                self.rodDisplay.image = UIImage(named: "hookRod")!

            case 2:
                self.rodDisplay.image = UIImage(named: "fishRod")!
                self.currFishName = self.fish.randomFishSelection()
                self.caughtAlert()
            default:
                print("")
            }
            self.isCaught = 0
        })
    }
    
    
    func castAnimation() {
        UIView.animate(withDuration: 1.4, animations: {
            self.rodDisplay.rotate(by: -Double.pi / 2, with: CGPoint(x: -0.5, y: 0.5))
        }, completion: { _ in
            self.rodDisplay.image = UIImage(named: "castRod")!
            UIView.animate(withDuration: 0.4, animations: {
                self.rodDisplay.rotate(by: 0.0, with: CGPoint(x: -0.5, y: 0.5))
            }, completion: { _ in
                UIView.animate(withDuration: 1.3, delay: 0.2, options: .curveEaseIn, animations: {
                //    self.mainView.alpha = 0.0
                }, completion: { _ in
                    self.performSegue(withIdentifier: "toGameView2", sender: nil)
                })
            })
            })
    }
    
    func gotAwayAlert(){
        let message: String = NSLocalizedString("catchFailError", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("catchFailErrorTitle", comment: ""), message: message, preferredStyle: .alert)
        let acknowledgeAction = UIAlertAction(title: NSLocalizedString("okay", comment: ""), style: .default)
        alert.addAction(acknowledgeAction)
        present(alert, animated: true)
    }
    
    func caughtAlert(){
        
        UIView.animate(withDuration: 0.7, animations: {
            self.rodDisplay.rotate(by: -Double.pi / 4, with: CGPoint(x: -0.5, y: 0.5))
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, animations: {
                self.rodDisplay.rotate(by: 0.0, with: CGPoint(x: -0.5, y: 0.5))
            }, completion: { _ in
                UIView.animate(withDuration: 1.3, delay: 0.2, options: .curveEaseIn, animations: {
                    //    self.mainView.alpha = 0.0
                })
        })
    })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {

            let caughtMenu = UIAlertController(title: "\(NSLocalizedString("youCaughtAlert", comment: "")) \(self.currFishName)!", message: "\(NSLocalizedString("whatWould", comment: ""))", preferredStyle: .actionSheet)
        let stay = UIAlertAction(title: NSLocalizedString("keepFishing", comment: ""), style: .default){ _ in
            self.addFishToCatches()
            self.rodDisplay.image = UIImage(named: "hookRod")!
        }
        let viewCatches = UIAlertAction(title: NSLocalizedString("stopFishing", comment: ""), style: .default){ _ in
            self.addFishToCatches()
            self.rodDisplay.image = UIImage(named: "hookRod")!
            self.performSegue(withIdentifier: "toMain", sender: nil)
        }
        
        let throwBack = UIAlertAction(title: NSLocalizedString("throwItBack", comment: ""), style: .destructive)
            
        caughtMenu.addAction(stay)
        caughtMenu.addAction(viewCatches)
        caughtMenu.addAction(throwBack)
            
            if let popoverController = caughtMenu.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            
        self.present(caughtMenu, animated: true, completion: nil)
        })
    }

    func addFishToCatches(){
        CoreDataStack.shared.saveItem(name: currFishName, dateCaught: Date())
    }
    
    func configureView() {
        imageViewBackground.image = UIImage(named: "lakeBackground")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        rodDisplay.image = UIImage(named: "hookRod")
        rodDisplay.contentMode = UIView.ContentMode.scaleAspectFill
        mainView.addSubview(rodDisplay)
        mainView.addSubview(imageViewBackground)
        mainView.sendSubviewToBack(imageViewBackground)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
        })
    }
    
    @IBAction func swipeDetected(_ sender: UISwipeGestureRecognizer) {
        castAnimation()
        homeButton.isEnabled = false
    }
}


