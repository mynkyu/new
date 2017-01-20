//
//  ViewController.swift
//  blink12_01
//
//  Created by 한민규 on 2016. 12. 1..
//  Copyright © 2016년 Blink. All rights reserved.
//

import UIKit
// pod 'Fusuma'
class ViewController: UIViewController {

    var scrollView : UIScrollView!
    let imageName = "KakaoTalk_Photo_2016-12-02-16-57-29.jpg"
    var image: UIImage!
    var imageView : UIImageView!
    var button : UIButton! = nil
    let textcontainer : UITextField! = nil
    var scrollViewWidth: CGFloat = 0.0
    var scrollViewHeight: CGFloat = 0.0
    var scrollViewX: CGFloat = 0.0
    var scrollViewY: CGFloat = 0.0
    var subView : UIView!
    
    
    //var colorArray = [UIColor]()
    
    
    func setImage(){
        image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        
        imageView.frame = view.frame
        imageView.center = view.center
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func setScrollView(){
        scrollView = UIScrollView()
        scrollViewWidth = self.view.frame.width/2.3
        scrollViewHeight = self.view.frame.height/3.4
        scrollViewX = self.view.center.x - (scrollViewWidth/2)
        scrollViewY = self.view.center.y - (scrollViewHeight/2)
        
        scrollView = UIScrollView(frame : CGRect.init(x: scrollViewX , y: scrollViewY, width: scrollViewWidth, height: scrollViewHeight ))
        
        scrollView.layer.cornerRadius = 7
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator=false
        
        setSubView()
    }
    func setSubView(){
        for i in 0..<5 {
            switch i {
            case 0:
                firstSubview(i)
                break
            case 1:
                secondSubview(i)
                break
            case 2:
                thirdSubview(i)
                break
            case 3:
                fourthSubview(i)
                break
            case 4:
                fifthSubview(i)
                break
            default:
                break
            }
            scrollView.contentSize.width = scrollViewWidth * CGFloat(5)
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
   
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func firstSubview(_ number: Int) -> Void{
        subView = UIView()
        subView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        let xPostion = self.scrollView.frame.width * CGFloat(number)
        subView.frame = CGRect.init(x: xPostion, y: 0, width: scrollViewWidth ,height: scrollViewHeight)
        self.scrollView.addSubview(subView)
        
        
        button = UIButton()
        button.frame = CGRect.init(x: scrollViewWidth/3 , y: scrollViewHeight*(2/5), width: scrollViewWidth/3, height: scrollViewHeight/5)
        button.setTitle("send", for: .normal)
        button.addTarget(self, action: #selector(buttonAction) , for: .touchUpInside)
        button.backgroundColor = UIColor.red
        subView.addSubview(button)
    }
    func buttonAction(){
        //print(scrollView.contentOffset)
        let offset: CGPoint = CGPoint.init(x: scrollView.contentOffset.x + scrollView.frame.width, y: 0)
        self.scrollView.setContentOffset(offset, animated: true)
        
        
    }
    func secondSubview(_ number: Int){
        
        subView = UIView()
        subView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        let xPostion = self.scrollView.frame.width * CGFloat(number)
        
        subView.frame = CGRect.init(x: xPostion, y: 0, width: scrollViewWidth ,height: scrollViewHeight)
        self.scrollView.addSubview(subView)
    
        button = UIButton()
        button.frame = CGRect.init(x: scrollViewWidth/3 , y: scrollViewHeight*(2/5), width: scrollViewWidth/3, height: scrollViewHeight/5)
        button.setTitle("send", for: .normal)
        button.addTarget(self, action: #selector(buttonAction) , for: .touchUpInside)
        button.backgroundColor = UIColor.red
        subView.addSubview(button)

    }
    func thirdSubview(_ number: Int){
        subView = UIView()
        subView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        let xPostion = self.scrollView.frame.width * CGFloat(number)
        
        subView.frame = CGRect.init(x: xPostion, y: 0, width: scrollViewWidth ,height: scrollViewHeight)
        self.scrollView.addSubview(subView)
        
        button = UIButton()
        button.frame = CGRect.init(x: scrollViewWidth/3 , y: scrollViewHeight*(2/5), width: scrollViewWidth/3, height: scrollViewHeight/5)
        button.setTitle("send", for: .normal)
        button.addTarget(self, action: #selector(buttonAction) , for: .touchUpInside)
        button.backgroundColor = UIColor.red
        subView.addSubview(button)

    }
    func fourthSubview(_ number: Int) {
        subView = UIView()
        subView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        let xPostion = self.scrollView.frame.width * CGFloat(number)
        
        subView.frame = CGRect.init(x: xPostion, y: 0, width: scrollViewWidth ,height: scrollViewHeight)
        self.scrollView.addSubview(subView)
        
        button = UIButton()
        button.frame = CGRect.init(x: scrollViewWidth/3 , y: scrollViewHeight*(2/5), width: scrollViewWidth/3, height: scrollViewHeight/5)
        button.setTitle("send", for: .normal)
        button.addTarget(self, action: #selector(buttonAction) , for: .touchUpInside)
        button.backgroundColor = UIColor.red
        subView.addSubview(button)

    }
    func fifthSubview(_ number: Int){
        subView = UIView()
        subView.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
        let xPostion = self.scrollView.frame.width * CGFloat(number)
        
        subView.frame = CGRect.init(x: xPostion, y: 0, width: scrollViewWidth ,height: scrollViewHeight)
        self.scrollView.addSubview(subView)
        
        button = UIButton()
        button.frame = CGRect.init(x: scrollViewWidth/3 , y: scrollViewHeight*(2/5), width: scrollViewWidth/3, height: scrollViewHeight/5)
        button.setTitle("send", for: .normal)
        button.addTarget(self, action: #selector(buttonNextController) , for: .touchUpInside)
        button.backgroundColor = UIColor.red
        subView.addSubview(button)

    }
    func buttonNextController(){
        present( mainController() , animated: true, completion: nil)
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setScrollView()
        view.addSubview(scrollView)
        view.addSubview(imageView)
        self.view.addSubview(scrollView)
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    


}
extension UIScrollView {
    func scrollToPage(_ index: UInt8, animated: Bool, after delay: TimeInterval) {
        let offset: CGPoint = CGPoint(x: CGFloat(index) * frame.size.width, y: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            self.setContentOffset(offset, animated: animated)
        })
    }
}

