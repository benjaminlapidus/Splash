//
//  reelRodVC.swift
//  Splash
//
//  Created by Ben Lapidus on 11/24/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class reelRodVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var reelInView: UIView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let fish1 = UIImageView(image: UIImage(named: "fishShadow")!)
    let fish2 = UIImageView(image: UIImage(named: "fishShadow")!)
    let fish3 = UIImageView(image: UIImage(named: "fishShadowRight")!)
    let fish4 = UIImageView(image: UIImage(named: "fishShadowRight")!)
    let fish5 = UIImageView(image: UIImage(named: "fishShadowRight")!)
    let fish6 = UIImageView(image: UIImage(named: "fishShadow")!)
    let hookIcon = UIImageView(image: UIImage(named: "hookIcon")!)
    var isCaught = 0
    var didTap: Int = 0
    var timer: Timer!
    var isSwipeEnabled = true
    var downTimer: Timer!
    var upTimer: Timer!
    var multiplyer = 1.0
    
    var fishWidth = 100
    var fishHeight = 38
    var hookSpeed: CGFloat = 2.0
    var timeMultiplier = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettings()

        NotificationCenter.default.addObserver(self, selector: #selector(fishSuccess), name: NSNotification.Name(rawValue: "success"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fishFail), name: NSNotification.Name(rawValue: "fail"), object: nil)
        blurEffect.effect = nil
        drawLineFromPoint(start: CGPoint(x: width/2, y: height/2),
                          toPoint: CGPoint(x: width/2, y: 0),
                          ofColor: .black,
                          inView: mainView)
        timer = Timer.scheduledTimer(timeInterval: 15.0*multiplyer, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timer.fire()
        
        hookIcon.frame = CGRect(x: width/2-8, y: height/2, width: 16, height: 16)
        mainView.addSubview(hookIcon)
        lineUp()
        uplineStop()
        lineDown()
        reelInView.isHidden = true
    }
    
    func configureSettings() {
        let defaults = UserDefaults.standard
        let hookSpeed = defaults.string(forKey: "Hook")
        let fishSpeed = defaults.string(forKey: "Speed")

        switch (hookSpeed!){
        case "Slow":
            self.hookSpeed = 2.0
        case "Medium":
            self.hookSpeed = 3.0
        case "Fast":
            self.hookSpeed = 4.0
        default:
            self.hookSpeed = 2.0
        }
        

        switch (fishSpeed!){
        case "Slow":
            self.multiplyer = 1.5
        case "Medium":
            self.multiplyer = 1.3
        case "Fast":
            self.multiplyer = 1.0
        default:
            self.multiplyer = 1.0
        }
    }
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.name = "fishingLine"
        shapeLayer.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer)
        view.isUserInteractionEnabled = true
        mainView.isUserInteractionEnabled = true
    }
    @IBAction func onReelButton(_ sender: UIButton) {
        let fishFrame1 = fish1.layer.presentation()!.frame
        let fishFrame2 = fish2.layer.presentation()!.frame
        let fishFrame3 = fish3.layer.presentation()!.frame
        let fishFrame4 = fish4.layer.presentation()!.frame
        let fishFrame5 = fish5.layer.presentation()!.frame
        let fishFrame6 = fish6.layer.presentation()!.frame
        let hookFrame = hookIcon.layer.presentation()!.frame

        if (fishFrame1.contains(hookFrame)) ||
            (fishFrame2.contains(hookFrame)) ||
            (fishFrame3.contains(hookFrame)) ||
            (fishFrame4.contains(hookFrame)) ||
            (fishFrame5.contains(hookFrame)) ||
            (fishFrame6.contains(hookFrame)){
            reelViewAnimations()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        }
    }
    
    func reelViewAnimations(){
        reelInView.isHidden = false
        timer.invalidate()
        isSwipeEnabled = false
        blurEffect.alpha = 0.9
        UIView.animate(withDuration: 2) {
            self.blurEffect.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        }
        mainView.bringSubviewToFront(blurEffect)
        mainView.bringSubviewToFront(reelInView)
        if (upTimer.isValid){
            uplineStop()
        }
        if (downTimer.isValid){
            downLineStop()
        }
        removeLayer(layerName: "fishingLine")
    }
    
    func animateFish(){
        fish1.frame = CGRect(x: 0-fishWidth, y: Int.random(in: 1..<Int(height)-fishHeight), width: fishWidth, height: fishHeight)
        fish2.frame = CGRect(x: 0-fishWidth, y: Int.random(in: 1..<Int(height)-fishHeight), width: fishWidth, height: fishHeight)
        fish3.frame = CGRect(x: Int(width+CGFloat(fishWidth)), y: Int.random(in: 1..<Int(height)-fishWidth), width: fishWidth, height: fishHeight)
        fish4.frame = CGRect(x: Int(width+CGFloat(fishWidth)), y: Int.random(in: 1..<Int(height)-fishWidth), width: fishWidth, height: fishHeight)
        fish5.frame = CGRect(x: Int(width+CGFloat(fishWidth)), y: Int.random(in: 1..<Int(height)-fishWidth), width: fishWidth, height: fishHeight)
        fish6.frame = CGRect(x: 0-fishWidth, y: Int.random(in: 1..<Int(height)-fishHeight), width: fishWidth, height: fishHeight)

        mainView.addSubview(fish1)
        mainView.addSubview(fish2)
        mainView.addSubview(fish3)
        mainView.addSubview(fish4)
        mainView.addSubview(fish5)
        mainView.addSubview(fish6)
        
        UIView.animate(withDuration: Double.random(in:5.0*multiplyer..<9.0*multiplyer), delay: 0.0, options: .curveLinear, animations: {
            self.fish1.frame.origin.x += self.width+100
        }, completion: { _ in
           self.fish1.removeFromSuperview()
        })
        UIView.animate(withDuration: Double.random(in:4.0*multiplyer..<5.0*multiplyer), delay: 2.0, options: .curveLinear, animations: {
            self.fish2.frame.origin.x += self.width+100
        }, completion: { _ in
            self.fish2.removeFromSuperview()
        })
        UIView.animate(withDuration: Double.random(in:5.0*multiplyer..<6.0*multiplyer), delay: 6.5, options: .curveLinear, animations: {
            self.fish3.frame.origin.x -= self.width+200
        }, completion: { _ in
            self.fish3.removeFromSuperview()
        })
        UIView.animate(withDuration: Double.random(in:4.0*multiplyer..<8.0*multiplyer), delay: 6.0, options: .curveLinear, animations: {
            self.fish4.frame.origin.x -= self.width+200
        }, completion: { _ in
            self.fish4.removeFromSuperview()
        })
        UIView.animate(withDuration: Double.random(in:4.0*multiplyer..<5.0*multiplyer), delay: 10.0, options: .curveLinear, animations: {
            self.fish5.frame.origin.x -= self.width+200
        }, completion: { _ in
            self.fish5.removeFromSuperview()
        })
        UIView.animate(withDuration: Double.random(in:5.0*multiplyer..<6.0*multiplyer), delay: 9.0, options: .curveLinear, animations: {
            self.fish6.frame.origin.x += self.width+100
        }, completion: { _ in
            self.fish6.removeFromSuperview()
        })
    }

    @objc func fireTimer() {
        animateFish()
    }
    
    func removeLayer(layerName: String) {
        for item in mainView.layer.sublayers ?? [] where item.name == layerName {
            item.removeFromSuperlayer()
        }
    }
    
    @IBAction func onSwipeUp(_ sender: UISwipeGestureRecognizer) {
    if (!upTimer.isValid && isSwipeEnabled){
        downLineStop()
        lineUp()
        }
    }
    
    @IBAction func onSwipeDown(_ sender: UISwipeGestureRecognizer) {
        
        if (!downTimer.isValid && isSwipeEnabled){
            uplineStop()
            lineDown()
        }
    }
    
    func lineUp(){
        upTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(up), userInfo: nil, repeats: true)
    }
    func lineDown(){
        downTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(down), userInfo: nil, repeats: true)
    }
    
    func uplineStop(){
        upTimer.invalidate()
    }
    
    func downLineStop(){
        downTimer.invalidate()
    }
    
    @objc func up() {
        if (hookIcon.layer.presentation()!.frame.origin.y >= 16){
            removeLayer(layerName: "fishingLine")
            hookIcon.frame.origin.y -= hookSpeed
            drawLineFromPoint(start: CGPoint(x: hookIcon.center.x, y: hookIcon.center.y), toPoint: CGPoint(x: width/2, y: 0), ofColor: .black, inView: mainView)
        }
    }
    
    @objc func down() {
        if (hookIcon.layer.presentation()!.frame.origin.y <= height-16){
            removeLayer(layerName: "fishingLine")
            hookIcon.frame.origin.y += hookSpeed
            drawLineFromPoint(start: CGPoint(x: hookIcon.center.x, y: hookIcon.center.y), toPoint: CGPoint(x: width/2, y: 0), ofColor: .black, inView: mainView)
        }
    }
    
    @objc func fishSuccess(notification: NSNotification){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.isCaught = 2
            self.performSegue(withIdentifier: "toGameView1", sender: nil)
        })
    }
    
    @objc func fishFail(notification: NSNotification){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.isCaught = 1
            self.performSegue(withIdentifier: "toGameView1", sender: nil)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is castRodVC
        {
            let vc = segue.destination as? castRodVC
            vc?.isCaught = self.isCaught
        }
    }
}
