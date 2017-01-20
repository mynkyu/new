//
//  cardStoryViewcontroller.swift
//  blink12_01
//
//  Created by 한민규 on 2016. 12. 22..
//  Copyright © 2016년 Blink. All rights reserved.
//

import UIKit
import KRWordWrapLabel

class cardStoryViewController: UIViewController {
    var number : Int!
    var cardScrollView : UIScrollView!
    var MaleCards = [UIImage]()
    var MaleStorys = [String]()
    let feMaleCards = [UIImage]()
    var feMaleStorys = [String]()
    var subView : UIView!
    var cardImage : UIImageView!
    var cancelButton : UIButton!
    
    func setCardScroll(){
        cardScrollView = UIScrollView()
        cardScrollView.frame = self.view.frame
        cardScrollView.isPagingEnabled = true
        cardScrollView.showsVerticalScrollIndicator = false
        
        setCards()
    }
    
    func setCards(){
        
       
            for i in 0..<6 {
                subView = UIView()
                subView.frame = CGRect.init(x:self.view.center.x - self.view.frame.width * 0.47 , y: self.view.center.y - self.view.frame.height * 0.47 + self.view.frame.height * CGFloat(i) , width: self.view.frame.width * (0.94), height: self.view.frame.height * (0.94))
                subView.backgroundColor = UIColor.white
                subView.layer.shadowColor = UIColor.gray.cgColor
                subView.layer.shadowOpacity = 1
                subView.layer.shadowOffset = CGSize(width: -1, height: 4)
                cardScrollView.addSubview(subView)
                
                cardImage = UIImageView(image: MaleCards[i])
                cardImage.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height * 0.7)
                cardImage.contentMode = .scaleAspectFill
                cardImage.clipsToBounds = true
                subView.addSubview(cardImage)
                
                
                let story = KRWordWrapLabel()
                story.text = MaleStorys[i]
                story.frame = CGRect.init(x: 0.05 * self.view.frame.width , y: subView.frame.height * 0.72, width: subView.frame.width * 0.9, height: subView.frame.height * 0.2)
                story.textAlignment = .center
                story.numberOfLines = 0
                story.lineBreakMode = .byWordWrapping
                story.textColor = UIColor.gray.withAlphaComponent(0.8)
                subView.addSubview(story)
            }
            cardScrollView.contentSize.height = self.view.frame.height * CGFloat(6)
        
        
    }
    func setCancel(){
        cancelButton = UIButton()
        let origImage = #imageLiteral(resourceName: "1482488355_back")
        let tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        
        cancelButton.layer.shadowColor = UIColor.gray.cgColor
        cancelButton.layer.shadowOpacity = 1
        cancelButton.layer.shadowOffset = CGSize(width: 1  , height: 4)
        
        //cancelButton.backgroundColor = UIColor.red
        cancelButton.setImage(tintedImage, for: .normal)
        cancelButton.tintColor = UIColor.gray.withAlphaComponent(0.8)
        cancelButton.frame = CGRect.init(x: self.view.frame.width/20, y: view.frame.height/22, width: view.frame.height/18, height: view.frame.height/18)
        cancelButton.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
    }
    func backToMain(){
        print("cancelButton")
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        MaleCards = [#imageLiteral(resourceName: "photo1"),#imageLiteral(resourceName: "photo2"),#imageLiteral(resourceName: "photo3"), #imageLiteral(resourceName: "photo4"), #imageLiteral(resourceName: "photo5"), #imageLiteral(resourceName: "photo6")]
        MaleStorys = ["안녕하세요, 서울대학교 경영학과 10학번에 재학 중인 김지목이라고 합니다.", "저는 음악을 좋아하고 특히 힙합을 좋아해요. 듣는 것도 좋아하고 간간이 공연도 하며 살고 있어요.", "디자인쪽에도 관심이 많아서 디자인 부전공도 얼마 전에 다 마쳤습니다.", "시 읽는 것도 좋아해서 동아리도 하고 그랬었는데 요새는 바빠서 잘 못 읽고 있어요.", "요새는 마음 맞는 친구들과 앱을 개발 중에 있는데 힘들고 바쁘지만 즐겁고 감사한 과정이라고 생각하고 있어요.", "마음이 통하고 대화가 통하는 좋은 분을 만나고 싶습니다! 감사합니다!"]
        
        
        
        setCardScroll()
        view.addSubview(cardScrollView)
        
        
        setCancel()
        view.addSubview(cancelButton)
        

        
    }

    
    
    
    
}
