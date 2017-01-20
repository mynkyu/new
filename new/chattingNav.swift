//
//  chattingNav.swift
//  new
//
//  Created by macPro on 2017. 1. 17..
//  Copyright © 2017년 macPro. All rights reserved.
//

import UIKit

class chattingNav: UINavigationController{
    var slPaging : SLPagingViewSwift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatTable = chatViewController()
        self.pushViewController(chatTable, animated: false)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("navi")
    }
    
    
}
