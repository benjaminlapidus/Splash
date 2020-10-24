//
//  CustomSegue.swift
//  Splash
//
//  Created by Ben Lapidus on 11/28/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        fade()
    }
    
    func fade () {
        let toViewController = self.destination
        let fromViewController = self.source

        let containerView = fromViewController.view.superview

        containerView?.addSubview(toViewController.view)
        toViewController.view.alpha = 0.0

        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            fromViewController.view.alpha = 0.0
        }, completion: { success in
            fromViewController.present(toViewController, animated: false, completion: nil)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                toViewController.view.alpha = 1.0
            })
        })
    }
}


