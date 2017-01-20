//
//  cardStoryViewcontroller.swift
//  blink12_01
//
//  Created by 한민규 on 2016. 12. 22..
//  Copyright © 2016년 Blink. All rights reserved.
//

import UIKit
import KRWordWrapLabel

class cardStoryViewController2: UIViewController {
    var number : Int!
    var cardScrollView : UIScrollView!
    var MaleCards = [UIImage]()
    var MaleStorys = [String]()
    var feMaleCards = [UIImage]()
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
            
            cardImage = UIImageView(image: feMaleCards[i])
            cardImage.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height * 0.7)
            cardImage.contentMode = .scaleAspectFill
            cardImage.clipsToBounds = true
            subView.addSubview(cardImage)
            
            
            let story = KRWordWrapLabel()
            story.text = feMaleStorys[i]
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
        feMaleCards = [#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "6")]
        feMaleStorys = ["반가워요! 저는 서강대학교에서 국어국문학을 공부하고 있는 23살 이우림이에요.", "문학을 좋아해서 국문과에 왔고, 문학을 더 잘 하고 싶어서 철학 복수전공도 하고 있어요! 어느 덧 마지막 학년만 남겨둔 상황이라 아쉽기도 해요.", "저는 영화와 시, 글을 정말 좋아해요. 이 사진은 제가 제일 좋아하는 영화인 '블루베리 나이츠'인데, 사실 장르를 불문하고 영화라면 다 좋아합니다.", "사실 전 감성적이지만 동시에 우유부단한 걸 싫어하는 분명한 성격이에요. 열정도 큰 사람이고 적극적이기도 하죠.", "사람을 좋아하고, 좋아하는 사람들에게 도움이 될 수 있다면 기뻐요. 아끼는 사람들에게 언제나 따뜻하고 든든한 사람이 되어주고 싶어요.", "2017년은 새롭게 도전하는 기회를 통해 얻는 깊은 배움이 많았으면 좋겠어요. 새로운 사람의 세계를 알아가는 일은 언제나 또 하나의 배움이에요. 함께 많은 얘기할 수 있었으면 좋겠어요. 감사합니다!"]
        
        setCardScroll()
        view.addSubview(cardScrollView)
        
        
        setCancel()
        view.addSubview(cancelButton)
        
        
        
    }
    
    
    
    
    
}
