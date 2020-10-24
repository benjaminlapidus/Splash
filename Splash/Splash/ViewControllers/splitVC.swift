//
//  splitVC.swift
//  Splash
//
//  Created by Ben Lapidus on 12/2/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class splitVC: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
}
