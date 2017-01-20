//
//  distanceCell.swift
//  new
//
//  Created by macPro on 2017. 1. 13..
//  Copyright © 2017년 macPro. All rights reserved.
//

import UIKit

class distanceCell: UITableViewCell {

    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderAction(_ sender: UISlider) {
        distance.text = "\(Int(sender.value)) 킬로미터"
    }
    
}
