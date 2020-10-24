//
//  fishCell.swift
//  Splash
//
//  Created by Ben Lapidus on 12/1/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class fishCell: UITableViewCell {
    
    @IBOutlet weak var fishImageView: UIImageView!
    
    @IBOutlet weak var caughtDate: UILabel!
    @IBOutlet weak var fishName: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        caughtDate.text = NSLocalizedString("caughtDate", comment: "")
        // Initialization code
    }
    
    @IBOutlet weak var fishDate: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
