//
//  settingsTVC.swift
//  Splash
//
//  Created by Ben Lapidus on 11/24/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class settingsTVC: UITableViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var fullView: UITableView!
    
    @IBOutlet weak var fishSpeedLabel: UILabel!
    
    @IBOutlet weak var reelDifficultyLabel: UILabel!
    
    @IBOutlet weak var hookSpeedLocalization: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var fishSpeed:[String] = ["🐇", "🚶","🐌"]
    @IBOutlet weak var fishSizeLabel: UILabel!
    @IBOutlet weak var fishSizeSlider: UISlider!
    
    @IBOutlet weak var hookSpeedSlider: UISlider!
    @IBOutlet weak var hookSpeedLabel: UILabel!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        fishSpeedLabel.text = NSLocalizedString("fishSpeed", comment: "")
        reelDifficultyLabel.text = NSLocalizedString("reelDifficulty", comment: "")
        hookSpeedLocalization.text = NSLocalizedString("hookSpeed", comment: "")
    
        fullView.isHidden = false
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.setValue(UIColor(red: 0.86, green: 0.75, blue: 0.30, alpha: 1.0), forKeyPath: "textColor")
        
        let defaults = UserDefaults.standard
        
        let hookSpeed = defaults.string(forKey: "Hook")
        let fishSize = defaults.string(forKey: "Size")
        let fishSpeed = defaults.string(forKey: "Speed")
        
        switch (hookSpeed!){
            case "Slow":
                hookSpeedSlider.setValue(Float(1.0), animated: true)
                hookSpeedLabel.text = NSLocalizedString("slow", comment: "")

            case "Medium":
                hookSpeedSlider.setValue(Float(2.0), animated: true)
                hookSpeedLabel.text = NSLocalizedString("medium", comment: "")
            case "Fast":
                hookSpeedSlider.setValue(Float(3.0), animated: true)
                hookSpeedLabel.text = NSLocalizedString("fast", comment: "")
            default:
                hookSpeedSlider.setValue(Float(1.0), animated: true)
                hookSpeedLabel.text = NSLocalizedString("slow", comment: "")
        }
        switch (fishSize!){
        case "Hard":
            fishSizeSlider.setValue(Float(1.0), animated: true)
            fishSizeLabel.text = NSLocalizedString("hard", comment: "")
        case "Medium":
            fishSizeSlider.setValue(Float(2.0), animated: true)
            fishSizeLabel.text = NSLocalizedString("medium", comment: "")
        case "Easy":
            fishSizeSlider.setValue(Float(3.0), animated: true)
            fishSizeLabel.text = NSLocalizedString("easy", comment: "")
        default:
            fishSizeSlider.setValue(Float(1.0), animated: true)
            fishSizeLabel.text = NSLocalizedString("hard", comment: "")
        }

        switch (fishSpeed!){
        case "Slow":
            pickerView.selectRow(2, inComponent:0, animated:true)
        case "Medium":
            pickerView.selectRow(1, inComponent:0, animated:true)
        case "Fast":
            pickerView.selectRow(0, inComponent:0, animated:true)
        default:
            pickerView.selectRow(0, inComponent:0, animated:true)
        }
    }
    
    @IBAction func fishSizeAction(_ sender: Any) {
    fishSizeSlider.setValue(Float(Int(fishSizeSlider.value)), animated: true)
        
        fishSizeLabel.text = String(fishSizeSlider.value)
        if (fishSizeSlider.value == 3.0){
            fishSizeLabel.text = NSLocalizedString("easy", comment: "")
        } else if (fishSizeSlider.value == 2.0){
            fishSizeLabel.text = NSLocalizedString("medium", comment: "")
        } else if (fishSizeSlider.value == 1.0){
            fishSizeLabel.text = NSLocalizedString("hard", comment: "")
        }
        UserDefaults.standard.set(fishSizeLabel.text!, forKey: "Size")
    }
    
    @IBAction func hookSpeedAction(_ sender: Any) {
    hookSpeedSlider.setValue(Float(Int(hookSpeedSlider.value)), animated: true)
        
        hookSpeedLabel.text = String(hookSpeedSlider.value)
        if (hookSpeedSlider.value == 3.0){
            hookSpeedLabel.text = NSLocalizedString("fast", comment: "")
        } else if (hookSpeedSlider.value == 2.0){
            hookSpeedLabel.text = NSLocalizedString("medium", comment: "")
        } else if (hookSpeedSlider.value == 1.0){
            hookSpeedLabel.text = NSLocalizedString("slow", comment: "")
        }
        
        UserDefaults.standard.set(hookSpeedLabel.text!, forKey: "Hook")
        UserDefaults.standard.synchronize()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return fishSpeed.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fishSpeed[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let value = fishSpeed[row]
        
        if value == "🐇"{
            UserDefaults.standard.set("Fast", forKey: "Speed")
        }
        if value == "🚶"{
            UserDefaults.standard.set("Medium", forKey: "Speed")
        }
        if value == "🐌"{
            UserDefaults.standard.set("Slow", forKey: "Speed")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
