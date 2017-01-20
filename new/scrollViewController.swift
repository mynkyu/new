//
//  scrollViewController.swift
//  new
//
//  Created by macPro on 2017. 1. 14..
//  Copyright © 2017년 macPro. All rights reserved.
//

import UIKit

class scrollViewController: UIViewController {
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScroll()
        // Do any additional setup after loading the view.
    }
    func setScroll(){
        self.scrollView.frame = CGRect.init(x: 0, y: self.view.frame.height / 20 , width: self.view.frame.width, height: self.view.frame.height * (19/20))
        //self.scrollView.backgroundColor = UIColor.red
        self.scrollView.isPagingEnabled = true
        self.scrollView.isScrollEnabled = false
        setControllers()
        self.view.addSubview(scrollView)
        
        
    }
    func setControllers(){
        let setting = setController()
        self.addChildViewController(setting)
        setting.didMove(toParentViewController: self)
        setting.view.frame = CGRect.init(x: self.scrollView.frame.width , y: 0 , width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        scrollView.addSubview(setting.view)
        
        
        let User = configureController()
        self.addChildViewController(User)
        User.didMove(toParentViewController: self)
        User.view.frame = CGRect.init(x: 0, y: 0 , width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        scrollView.addSubview(User.view)
        
        scrollView.contentSize.width = scrollView.frame.width * 2
    }
    
}
