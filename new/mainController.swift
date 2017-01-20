//
//  mainController.swift
//  blink12_01
//
//  Created by 한민규 on 2016. 12. 6..
//  Copyright © 2016년 Blink. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import Firebase
import Koloda



class mainController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, KolodaViewDelegate, KolodaViewDataSource {
    
    var button : UIButton! = nil
    let picker = UIImagePickerController()
    var profileImage: UIImage!
    var imageView : UIImageView!
    var buttonImage : UIImage!
    var scrollViewCover : UIScrollView!
    var controlView : UIView!
    //var sampleUsers = [User]()
    var navigationBar : UINavigationBar!
    var textView : UILabel!
    var buttonView: UIView!
    var titleText : UILabel!
    var infoText : UILabel!
    let kolodaView = KolodaView()
    var tinderViews = [UIView]()
    var firstButtonView = UIView()
    //var sample_1 = People()
    //var sample_2 = People()
    var users = [People]()
    
    
    //["name" : "김지목", "infoText": "23km / 비흡연 / 불교 / 26세", "titleText" : "음악을 좋아하는 감성 청년", "coverPhoto" : #imageLiteral(resourceName: "photo1")]
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return users.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        print("index : ", index)
       
        
        return tinderViews[index]
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView",
                                                  owner: self, options: nil)?[0] as? OverlayView
    }
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("run out!")
        
        
        kolodaView.resetCurrentCardIndex()
 
    }
    
    
    
    func setPicker(){
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func setImageView(){
        print("setting imageView")
        imageView = UIImageView(image: profileImage)
        imageView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height/2)
        imageView.contentMode = .scaleAspectFill
        //imageView.frame = view.frame
        imageView.center = view.center
        
        //imageView.center = view.center
        //imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
    }
    func setControlView(){
        controlView = UIView()
        controlView.backgroundColor = UIColor.gray.withAlphaComponent(0.0)
        controlView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height/10)
        
        let blinkLabel = UILabel()
        blinkLabel.text = "Blink"
        blinkLabel.textAlignment = .center
        blinkLabel.textColor = UIColor.darkGray.withAlphaComponent(0.79)
        blinkLabel.frame = CGRect.init(x: self.view.center.x - self.view.frame.width/6, y: view.frame.height/25, width: view.frame.width/3, height: view.frame.height/20)
        controlView.addSubview(blinkLabel)
        
        
        let menuButton = UIButton(type: .custom)
        let origImage = #imageLiteral(resourceName: "burger")
        let tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        menuButton.setImage(tintedImage, for: .normal)
        menuButton.frame = CGRect.init(x: self.view.frame.width/35, y: view.frame.height/25, width: view.frame.height/20, height: view.frame.height/20)
        menuButton.tintColor = UIColor.darkGray.withAlphaComponent(0.79)
        controlView.addSubview(menuButton)
        
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if selectedImageFromPicker != nil {
            profileImage = selectedImageFromPicker
            print("image picked and put in to profile Image")
            
            self.imageView.image = profileImage
            //uploadPic()
            
        }else{
            print("null image")
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func setFirst(){
        print("ㅋㅋㅋㅋ")
        let subView = tinderViews[0]
        
        subView.frame = kolodaView.frame
        print("width: ", subView.frame.width)
        
        print("height: ", subView.frame.height)
        
        subView.backgroundColor = UIColor.white
        subView.layer.shadowColor = UIColor.gray.cgColor
        subView.layer.shadowOpacity = 1
        subView.layer.shadowOffset = CGSize(width: -1, height: 4)
        subView.layer.cornerRadius = 2.5
        //scrollViewCover.addSubview(subView)
        
        let imageView=UIImageView(image: #imageLiteral(resourceName: "photo1"))
        
        imageView.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height * 0.63)
        print("width: ", imageView.frame.width)
        
        print("height: ", imageView.frame.height)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        subView.addSubview(imageView)
        
        let buttonView = UIView()///////////////////////////////
        buttonView.backgroundColor = UIColor.white
        buttonView.frame = CGRect.init(x: subView.center.x - subView.frame.width/6.4, y: subView.frame.height*(4.83/6), width: subView.frame.width/3.2, height: subView.frame.height/7)
        //buttonView.center = self.view.center
        buttonView.layer.cornerRadius = 2.5
        buttonView.layer.shadowColor = UIColor.lightGray.cgColor
        buttonView.layer.shadowOpacity = 1
        buttonView.layer.shadowOffset = CGSize(width: -1, height: 5)
        subView.addSubview(buttonView)
        
        
        let titleText = UILabel()
        
        titleText.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width/2 , y: subView.frame.height * 0.61, width: subView.frame.width, height: subView.frame.height/10)
        titleText.backgroundColor = UIColor.white
        titleText.textColor = UIColor.gray.withAlphaComponent(0.95)
        titleText.textAlignment = .center
        titleText.text = "음악을 좋아하는 감성 청년"
        subView.addSubview(titleText)
        
        
        let separatorView = UIView()
        separatorView.frame = CGRect.init(x: subView.center.x - buttonView.frame.width/11.2 , y: subView.frame.height * 0.694, width: buttonView.frame.width/5.6, height: buttonView.frame.height/36)
        separatorView.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        subView.addSubview(separatorView)
        
        
        let infoText = UILabel()
        infoText.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width/2 , y: subView.frame.height * 0.71, width: subView.frame.width, height: subView.frame.height/20)
        infoText.backgroundColor = UIColor.white
        infoText.textAlignment = .center
        infoText.textColor = UIColor.gray.withAlphaComponent(0.64)
        infoText.text = "23km / 비흡연 / 불교 / 26세"
        subView.addSubview(infoText)
        
        
        let textView = UILabel()
        textView.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width * (2/3) , height: subView.frame.height/5)
        textView.center = buttonView.center
        textView.textAlignment = .center
        textView.numberOfLines = 2
        textView.textColor = UIColor.gray.withAlphaComponent(0.8)
        textView.text = "by\njimok kim"
        textView.contentMode = .center
        subView.addSubview(textView)
        
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.firstTapAction))
        //tapGesture.delegate = SLPagingViewSwift()
         
        //buttonView.isUserInteractionEnabled = true
        buttonView.addGestureRecognizer(tapGesture)
        
    }
    
    func firstTapAction(){
        print("gesture recognized")
        
        present( cardStoryViewController() , animated: true, completion: nil)
        
    }
    func setSecond(){
        let subView = tinderViews[1]
        
        subView.frame = kolodaView.frame
        subView.backgroundColor = UIColor.white
        subView.layer.shadowColor = UIColor.gray.cgColor
        subView.layer.shadowOpacity = 1
        subView.layer.shadowOffset = CGSize(width: -1, height: 4)
        subView.layer.cornerRadius = 2.5
        //scrollViewCover.addSubview(subView)
        
        let imageView=UIImageView(image: #imageLiteral(resourceName: "1"))
        imageView.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height*0.63)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        subView.addSubview(imageView)
        
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor.white
        buttonView.frame = CGRect.init(x: subView.center.x - subView.frame.width/6.4, y: subView.frame.height*(4.83/6), width: subView.frame.width/3.2, height: subView.frame.height/7)
        //buttonView.center = self.view.center
        buttonView.layer.cornerRadius = 2.5
        buttonView.layer.shadowColor = UIColor.lightGray.cgColor
        buttonView.layer.shadowOpacity = 1
        buttonView.layer.shadowOffset = CGSize(width: -1, height: 5)
        subView.addSubview(buttonView)
        
        
        let titleText = UILabel()
        titleText.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width/2 , y: subView.frame.height * 0.61, width: subView.frame.width, height: subView.frame.height/10)
        titleText.backgroundColor = UIColor.white
        titleText.textColor = UIColor.gray.withAlphaComponent(0.95)
        titleText.textAlignment = .center
        titleText.text = "세상을 울리는 종소리 같은 여자"
        subView.addSubview(titleText)
        
        
        let separatorView = UIView()
        separatorView.frame = CGRect.init(x: subView.center.x - buttonView.frame.width/11.2 , y: subView.frame.height * 0.694, width: buttonView.frame.width/5.6, height: buttonView.frame.height/36)
        separatorView.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        subView.addSubview(separatorView)
        
        
        let infoText = UILabel()
        infoText.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width/2 , y: subView.frame.height * 0.71, width: subView.frame.width, height: subView.frame.height/20)
        infoText.backgroundColor = UIColor.white
        infoText.textAlignment = .center
        infoText.textColor = UIColor.gray.withAlphaComponent(0.64)
        infoText.text = "5km / 비흡연 / 기독교 / 23세"
        subView.addSubview(infoText)
        
        
        let textView = UILabel()
        textView.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width * (2/3) , height: subView.frame.height/5)
        textView.center = buttonView.center
        textView.textAlignment = .center
        textView.numberOfLines = 2
        textView.textColor = UIColor.gray.withAlphaComponent(0.8)
        textView.text = "by\nUllim Lee"
        textView.contentMode = .center
        subView.addSubview(textView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(secondTapAction))
        buttonView.addGestureRecognizer(tapGesture)
        
        
    }
    func secondTapAction(){
        print("gesture recognized")
        
        present( cardStoryViewController2() , animated: true, completion: nil)
        
    }
    func setThird(){
        let subView = tinderViews[2]
        
        subView.frame = kolodaView.frame
        subView.backgroundColor = UIColor.white
        subView.layer.shadowColor = UIColor.gray.cgColor
        subView.layer.shadowOpacity = 1
        subView.layer.shadowOffset = CGSize(width: -1, height: 4)
        subView.layer.cornerRadius = 100
        //scrollViewCover.addSubview(subView)
        
        let imageView=UIImageView(image: #imageLiteral(resourceName: "asdfkr21"))
        imageView.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height*0.63)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        subView.addSubview(imageView)
        
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor.white
        buttonView.frame = CGRect.init(x: subView.center.x - subView.frame.width/6.4, y: subView.frame.height*(4.83/6), width: subView.frame.width/3.2, height: subView.frame.height/7)
        //buttonView.center = self.view.center
        buttonView.layer.cornerRadius = 4
        buttonView.layer.shadowColor = UIColor.lightGray.cgColor
        buttonView.layer.shadowOpacity = 1
        buttonView.layer.shadowOffset = CGSize(width: -1, height: 5)
        subView.addSubview(buttonView)
        
        
        let titleText = UILabel()
        
        titleText.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width/2 , y: subView.frame.height * 0.61, width: subView.frame.width, height: subView.frame.height/10)
        titleText.backgroundColor = UIColor.white
        titleText.textColor = UIColor.gray.withAlphaComponent(0.95)
        titleText.textAlignment = .center
        titleText.text = "카드스토리가 등록되지 않았습니다."
        subView.addSubview(titleText)
        
        
        let separatorView = UIView()
        separatorView.frame = CGRect.init(x: subView.center.x - buttonView.frame.width/11.2 , y: subView.frame.height * 0.694, width: buttonView.frame.width/5.6, height: buttonView.frame.height/36)
        separatorView.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        subView.addSubview(separatorView)
        
        
        let infoText = UILabel()
        infoText.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width/2 , y: subView.frame.height * 0.71, width: subView.frame.width, height: subView.frame.height/20)
        infoText.backgroundColor = UIColor.white
        infoText.textAlignment = .center
        infoText.textColor = UIColor.gray.withAlphaComponent(0.64)
        infoText.text = "0km / 비흡연 / 기독교 / 22세"
        subView.addSubview(infoText)
        
        
        let textView = UILabel()
        textView.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width * (2/3) , height: subView.frame.height/5)
        textView.center = buttonView.center
        textView.textAlignment = .center
        textView.numberOfLines = 2
        textView.textColor = UIColor.gray.withAlphaComponent(0.8)
        textView.text = "카드\n작성하기"
        textView.contentMode = .center
        subView.addSubview(textView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(thirdTapAction))
        buttonView.addGestureRecognizer(tapGesture)
    }
    func thirdTapAction(){
        print("gesture recognized")
        
        present( editorViewController(), animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.view.backgroundColor = UIColor.white
        //print("1")
        tinderViews = [UIView(),UIView()]
        //print("2")
        kolodaView.backgroundColor = UIColor.white
        
        
        //let dictionary = ["name" : "김지목", "infoText": "23km / 비흡연 / 불교 / 26세", "titleText" : "음악을 좋아하는 감성 청년", ]
        let sample_1 = People(infoText: "23km / 비흡연 / 불교 / 26세", titleText : "음악을 좋아하는 감성 청년", name : "김지목", coverPhoto : #imageLiteral(resourceName: "photo1"))
        let sample_2 = People(infoText: "5km / 비흡연 / 기독교 / 23세", titleText : "세상을 울리는 종소리같은 여자", name : "이우림", coverPhoto : #imageLiteral(resourceName: "1"))
        
        /*
        let dictionary2 = ["name" : "이우림", "infoText": "5km / 비흡연 / 기독교 / 23세", "titleText" : "세상을 울리는 종소리같은 여자"]
        sample_2.setValuesForKeys(dictionary2)
       
        */
        users.append(sample_1)
        users.append(sample_2)
        
        
        //print("current user: ", (FIRAuth.auth()?.currentUser?.uid)!)
            
       
        
        kolodaView.frame = CGRect.init(x: 0, y: self.view.frame.height/10 , width: self.view.frame.width * 0.96, height: self.view.frame.height * 0.88)
        kolodaView.center.x = self.view.center.x
        
        self.view.addSubview(kolodaView)
        setCoverStorys()
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
        //setSamples()
        print("sample over")
        
        
        //setFirst()
        //setSecond()
        //setThird()
        //print("4")
        
        
        
        //setScrollCover()
        //view.addSubview(scrollViewCover)
        
        
        //view.addSubview(controlView)
        //print("task done")
    }
    /*
    func setSamples(){
        FIRDatabase.database().reference().child("sample-users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let url = URL(string: ((dictionary["coverCard"] as! NSDictionary )["imageURL"] as! String))
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async {
                        let user = People.init(infoText: "샘플 유저", titleText: ((dictionary["coverCard"] as!NSDictionary)["content"]) as! String, name: snapshot.key, coverPhoto: UIImage(data: data!)!)
                        self.users.append(user)
                        print("타이틀: ",((dictionary["coverCard"] as! NSDictionary)["content"]) as! String)
                        print("이미지: ",((dictionary["coverCard"] as! NSDictionary)["imageURL"]) as! String)
                        self.tinderViews.append(UIView())
                        
                        self.setCoverStorys()
                        self.kolodaView.swipe(.right)
                        
                    }
                }
                
            }
            
        }, withCancel: nil)
    }
    */
        
    func setCoverStorys(){
        print("users.count: ",users.count)
        for i in 0..<users.count {
            
            let subView = tinderViews[i]
            subView.frame = kolodaView.frame
            subView.backgroundColor = UIColor.white
            subView.layer.shadowColor = UIColor.gray.cgColor
            subView.layer.shadowOpacity = 1
            subView.layer.shadowOffset = CGSize(width: -1, height: 4)
            subView.layer.cornerRadius = 10
            //subView.clipsToBounds = true
            //scrollViewCover.addSubview(subView)
            
            
            let imageView=UIImageView(image: users[i].coverPhoto)
            imageView.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height*0.63)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            subView.addSubview(imageView)
            
            let buttonView = UIView()
            buttonView.backgroundColor = UIColor.white
            buttonView.frame = CGRect.init(x: subView.center.x - subView.frame.width/6.4, y: subView.frame.height*(4.83/6), width: subView.frame.width/3.2, height: subView.frame.height/7)
            //buttonView.center = self.view.center
            buttonView.layer.cornerRadius = 2.5
            buttonView.layer.shadowColor = UIColor.lightGray.cgColor
            buttonView.layer.shadowOpacity = 1
            buttonView.layer.shadowOffset = CGSize(width: -1, height: 5)
            subView.addSubview(buttonView)
            
            
            let titleText = UILabel()
            titleText.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width/2 , y: subView.frame.height * 0.61, width: subView.frame.width, height: subView.frame.height/10)
            titleText.backgroundColor = UIColor.white
            titleText.textColor = UIColor.gray.withAlphaComponent(0.95)
            titleText.textAlignment = .center
            titleText.text = users[i].titleText
            subView.addSubview(titleText)
            
            
            let separatorView = UIView()
            separatorView.frame = CGRect.init(x: subView.frame.width/2 - buttonView.frame.width/11.2 , y: subView.frame.height * 0.694, width: buttonView.frame.width/5.6, height: buttonView.frame.height/36)
            separatorView.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
            subView.addSubview(separatorView)
            
            
            let infoText = UILabel()
            infoText.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width/2 , y: subView.frame.height * 0.71, width: subView.frame.width, height: subView.frame.height/20)
            infoText.backgroundColor = UIColor.white
            infoText.textAlignment = .center
            infoText.textColor = UIColor.gray.withAlphaComponent(0.64)
            infoText.text = users[i].infoText
            subView.addSubview(infoText)
            
            
            let textView = UILabel()
            textView.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width * (2/3) , height: subView.frame.height/5)
            textView.center = buttonView.center
            textView.textAlignment = .center
            textView.numberOfLines = 2
            textView.textColor = UIColor.gray.withAlphaComponent(0.8)
            textView.text = "by\n\(users[i].name)"
            textView.contentMode = .center
            subView.addSubview(textView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            buttonView.addGestureRecognizer(tapGesture)
            

            
        }
    }
    func tapAction(){
        print("yes")
    }
    /////////////////////////////////////////////////사진 업로드/////////////////////////////////////////////////
    func uploadPic(){
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(self.imageView.image!) {
            
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                /*
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    
                    let values = ["name": "me", "email": "me.naver.com", "profileImageUrl": profileImageUrl]
                    let uid = FIRAuth.auth()?.currentUser?.uid
                    
                    //self.registerUserIntoDatabaseWithUID(uid: uid!, values: values as [String : AnyObject])
                }
                */
            })
        }
    }
    /*
     private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
     let ref = FIRDatabase.database().reference()
     let usersReference = ref.child("users").child(uid)
     
     usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
     
     if err != nil {
     print(err!)
     return
     }
     
     self.dismiss(animated: true, completion: nil)
     })
     }
     */
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
}
