//
//  chatViewController.swift
//  new
//
//  Created by macPro on 2017. 1. 16..
//  Copyright © 2017년 macPro. All rights reserved.
//

import UIKit

class chatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //let nav = UINavigationController()
    var SLPaging : SLPagingViewSwift!
    
    
    func setTable(){
        let tableView = UITableView()
        tableView.frame = CGRect.init(x: 0, y: 0 , width: self.view.frame.width, height: self.view.frame.height - 60)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.contentSize.height = tableView.frame.height * 10
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let initialCount = 0
        let pageSize = 50
        let chatController = DemoChatViewController()
        var dataSource: FakeDataSource!
        
        dataSource = FakeDataSource(count: initialCount, pageSize: pageSize)
        chatController.dataSource = dataSource
        chatController.messageSender = dataSource.messageSender
        
        
               
        self.navigationController?.pushViewController(chatController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = Bundle.main.loadNibNamed("chatPersonCell", owner: self, options: nil)?.first as! chatPersonCell
            cell.profileName.text = "김지목"
            cell.profileImage.image = #imageLiteral(resourceName: "photo1")
            return cell
        case 1:
            let cell = Bundle.main.loadNibNamed("chatPersonCell", owner: self, options: nil)?.first as! chatPersonCell
            cell.profileName.text = "이우림"
            cell.profileImage.image = #imageLiteral(resourceName: "1")
            return cell
        case 2:
            let cell = Bundle.main.loadNibNamed("chatPersonCell", owner: self, options: nil)?.first as! chatPersonCell
            cell.profileName.text = "김또깡"
            cell.profileImage.image = #imageLiteral(resourceName: "goldengate")
            return cell
    
        default:
            let cell = Bundle.main.loadNibNamed("chatPersonCell", owner: self, options: nil)?.first as! chatPersonCell
            cell.profileName.text = "이우림"
            cell.profileImage.image = #imageLiteral(resourceName: "1")
            return cell
        }
        
        
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 61.5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func viewDidAppear(_ animated: Bool) {
        //SLPaging.scrollView.isScrollEnabled = true
        print("table View")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setTable()
        
        
    }
    

    
}
