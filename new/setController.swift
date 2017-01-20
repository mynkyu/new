//
//  setController.swift
//  new
//
//  Created by macPro on 2017. 1. 13..
//  Copyright © 2017년 macPro. All rights reserved.
//

import UIKit
struct cellData{
    let cell: Int!
    let text: String!
    let image: UIImage!
    
}

class setController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var arrayOfCellData = [cellData]()
    
    
    func setTable(){
        let tableView = UITableView()
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentSize.height = self.view.frame.height * 2
        self.view.addSubview(tableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
            
        case 2:
            return 1
            
        case 3:
            return 4
            
        case 4:
            return 1
        
        default:
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell=Bundle.main.loadNibNamed("privateCell", owner: self, options: nil)?.first as! privateCell
            return cell
        case 1:
            let cell=Bundle.main.loadNibNamed("distanceCell", owner: self, options: nil)?.first as! distanceCell
            return cell
        case 2:
            let cell=Bundle.main.loadNibNamed("ageCell", owner: self, options: nil)?.first as! ageCell
            return cell
        case 3 :
            switch indexPath.row {
            case 0:
                let cell = Bundle.main.loadNibNamed("genderCell", owner: self, options: nil)?.first as! genderCell
                return cell
            case 1:
                let cell = Bundle.main.loadNibNamed("genderSelectCell", owner: self, options: nil)?.first as! genderSelectCell
                cell.gender.text = "남자"
                return cell
            case 2:
                let cell = Bundle.main.loadNibNamed("genderSelectCell", owner: self, options: nil)?.first as! genderSelectCell
                cell.gender.text = "여자"
                return cell
            case 3:
                let cell = Bundle.main.loadNibNamed("genderSelectCell", owner: self, options: nil)?.first as! genderSelectCell
                cell.gender.text = "남자 & 여자"
                return cell
            default:
                let cell = Bundle.main.loadNibNamed("genderSelectCell", owner: self, options: nil)?.first as! genderSelectCell
                cell.gender.text = "남자 & 여자"
                return cell
            }
        
        case 4 :
            let cell = Bundle.main.loadNibNamed("pushCell", owner: self, options: nil)?.first as! pushCell
            return cell
        
        default:
            let cell=Bundle.main.loadNibNamed("distanceCell", owner: self, options: nil)?.first as! distanceCell
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            
            return 40
        case 1:
            
            return 60
        case 2:
           
            return 60
        case 3 :
            switch indexPath.row {
            case 0:
                return 30
            case 1:
                return 30
            case 2:
                return 30
            case 3:
                return 30
            default:
                return 30
            }
            
        case 4 :
            return 40
            
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect.init(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height)
        setTable()
        
        arrayOfCellData=[cellData(cell:1, text: "food1", image: #imageLiteral(resourceName: "5")),cellData(cell:2, text: "food2", image: #imageLiteral(resourceName: "2")),cellData(cell:3, text: "food3", image: #imageLiteral(resourceName: "photo2")),cellData(cell:4, text: "food4", image: #imageLiteral(resourceName: "photo5")) ]

        
        
    }
}
