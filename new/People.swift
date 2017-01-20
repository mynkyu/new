//
//  People.swift
//  blink12_01
//
//  Created by User on 2017. 1. 2..
//  Copyright © 2017년 Blink. All rights reserved.
//

import UIKit

class People: NSObject{

    var coverPhoto = UIImage()
    var infoText = String()
    var titleText = String()
    var name = String()
    
    init(infoText : String , titleText : String , name : String, coverPhoto : UIImage) {
        self.coverPhoto = coverPhoto
        self.infoText = infoText
        self.titleText = titleText
        self.name = name
    }
}
