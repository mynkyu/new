//
//  selectionController.swift
//  new
//
//  Created by macPro on 2017. 1. 8..
//  Copyright © 2017년 macPro. All rights reserved.
//

import UIKit

class selectionController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }

   
}
