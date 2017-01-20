//
//  configureController.swift
//  new
//
//  Created by macPro on 2017. 1. 7..
//  Copyright © 2017년 macPro. All rights reserved.
//

import UIKit
import BubbleTransition
import FirebaseAuth

class configureController: UIViewController, UIViewControllerTransitioningDelegate {
    let circleView = UIImageView()
    let transition = BubbleTransition()
    var likeList = [String]()
    var separatorView : UIView!
    
    @IBOutlet weak var transitionButton: UIButton!
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    func setProfile(){
        circleView.image = #imageLiteral(resourceName: "photo6")
        circleView.frame = CGRect.init(x: view.frame.width/2 - view.frame.width/5.4  , y: view.frame.height/5, width: view.frame.width/2.4, height: view.frame.width/2.4)
        circleView.contentMode = .scaleAspectFill
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = circleView.frame.width/2
        self.view.addSubview(circleView)
    }
    func setEdit(){
        let editButton = UIButton()
        let origImage = #imageLiteral(resourceName: "1483815687_15.Pencil")
        let tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        editButton.setImage(tintedImage, for: .normal)
        editButton.clipsToBounds = true
        editButton.tintColor = UIColor.white
        editButton.backgroundColor = UIColor.purple
        editButton.frame = CGRect.init(x: self.view.frame.width/2 + self.circleView.frame.width * 0.22, y: self.circleView.center.y + self.circleView.frame.height * 0.22, width: self.circleView.frame.width/4, height: self.circleView.frame.height/4)
        editButton.layer.cornerRadius = editButton.frame.width/2
        editButton.imageView?.sizeThatFits(CGSize.init(width: editButton.frame.width/1.5, height: editButton.frame.height/1.5))
        editButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(editButton)
        
    }
    func buttonAction(){
        present(editorViewController(), animated: true, completion: nil)
    }
    func setName(){
        let name = UILabel()
        name.text = "김지목"
        name.font = UIFont.systemFont(ofSize: 25.0 , weight: 0)
        name.frame = CGRect.init(x: self.circleView.center.x-self.view.frame.width/8, y: self.view.frame.height * 0.42, width: self.view.frame.width/4, height: self.view.frame.height/10)
        name.textAlignment = .center
        self.view.addSubview(name)
    }
    func setInfo(){
        let Info = UILabel()
        Info.text = "blink 기획부장 \nSeoul national Univ."
        Info.textAlignment = .center
        Info.frame = CGRect.init(x: self.circleView.center.x - self.view.frame.width/8 , y: self.view.frame.height * 0.49, width: self.view.frame.width, height: self.view.frame.height/10)
        Info.textColor = UIColor.gray.withAlphaComponent(0.7)
        
        Info.numberOfLines = 2
        Info.center.x = self.view.center.x
        self.view.addSubview(Info)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    func setSeparator(){
        let separator = UIView()
        separator.frame = CGRect.init(x: self.view.frame.width/2 - self.view.frame.width * 0.45 , y: self.view.frame.height * 0.75 , width: self.view.frame.width * 0.9, height: 1.5)
        separator.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        self.view.addSubview(separator)
    }
    func setSeparatorView(){
        separatorView = UIView()
        separatorView.frame = CGRect.init(x: 0 , y: self.view.frame.height * 0.76 , width: self.view.frame.width , height:  self.view.frame.height * 0.24)
        separatorView.backgroundColor = UIColor.white
        self.view.addSubview(separatorView)
    }
    func setLikeLabel(){
        
        for i in 0..<likeList.count {
            let label = UILabel()
            label.text = likeList[i]
            label.layer.borderColor = UIColor.red.cgColor
            label.textColor = UIColor.red
            //label.frame
            
        }
        
        
    }
    func setLogOut(){
        let logoutButton = UIButton()
        logoutButton.frame = CGRect.init(x: 0, y: 0, width: 30 , height: 30)
        let origImage = #imageLiteral(resourceName: "1482743299_Close")
        let tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        logoutButton.setImage(tintedImage, for: .normal)
        //logoutButton.center = separatorView.center
        logoutButton.tintColor = UIColor.darkGray
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        separatorView.addSubview(logoutButton)

    }
    func handleLogout(){
        print("logging out process")
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = loginViewController()
        present(loginController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        likeList = ["연애의 모든것","직장인","야밤의 공대생 만화","우리 연애 할래?","일일영감"]
        
        setProfile()
        setEdit()
        setName()
        setInfo()
        setSeparator()
        setSeparatorView()
        setLikeLabel()
        setLogOut()
        
    }

    
}
