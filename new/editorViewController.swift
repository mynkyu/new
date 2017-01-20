//
//  editorViewController.swift
//  blink12_01
//
//  Created by User on 2016. 12. 26..
//  Copyright © 2016년 Blink. All rights reserved.
//

import UIKit
import KRWordWrapLabel
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import Fusuma

class editorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate, FusumaDelegate{
    

    var number : Int!
    let cardScrollView = UIScrollView()
    var MaleCards = [UIImage]()
    var MaleStorys = [String]()
    let feMaleCards = [UIImage]()
    var feMaleStorys = [String]()
    let picker = UIImagePickerController()
    var who : String!
    var subView : UIView!
    var cardImages = [UIImageView]()
    var cardViews = [UIView]()
    var index = 0;
    var cancelButton : UIButton!
    var resultImage : UIImage!
    let addButton = UIButton()
    let deleteButton = UIButton()
    var cardStorys = [UITextField]()
    var doneButtons = [UIButton]()
    let list = LinkedList<Card>()
    var currentPage : NSInteger! = 0
    let sampleREF = FIRDatabase.database().reference().child("sample-users").childByAutoId()
    
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    func fusumaImageSelected(_ image: UIImage) {
        resultImage = image
        cardImages[index].contentMode = .scaleAspectFill
        cardImages[index].image = resultImage
        print("Image selected")
    }
    open func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        print("Called just after FusumaViewController is dismissed.")
    }
    // Return the image but called after is dismissed.
    func fusumaDismissedWithImage(_ image: UIImage) {
        
        print("Called just after FusumaViewController is dismissed.")
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Called just after a video has been selected.")
    }
    
    // When camera roll is not authorized, this method is called.
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
    func fusumaClosed(){
        print("fusuma closed")
    }
    open func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        resultImage = image
        list.node(atIndex: index)?.value.imageView.contentMode = .scaleToFill
        list.node(atIndex: index)?.value.imageView.image = resultImage
        print("Image selected")
        
    }
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    
    func setCardScroll(){
        cardScrollView.frame = self.view.frame
        cardScrollView.isPagingEnabled = true
        cardScrollView.showsVerticalScrollIndicator = false
        
        //setCards()
    }
    func setAdd(){
        let origImageForAdd = #imageLiteral(resourceName: "1482745919_ExpandMore")
        let tintedImageForAdd = origImageForAdd.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        addButton.setImage(tintedImageForAdd, for: .normal)
        addButton.tintColor = UIColor.gray.withAlphaComponent(0.8)
        addButton.frame = CGRect.init(x: view.frame.width/2 - view.frame.height/30, y: view.frame.height * 0.88 , width: view.frame.height/15, height: view.frame.height/15)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        addButton.layer.shadowColor = UIColor.gray.cgColor
        addButton.layer.shadowOpacity = 1
        addButton.layer.shadowOffset = CGSize(width: 1  , height: 2)

    }
    func addButtonAction(){
        let newCard = Card()
        //print(currentPage)
        
        arrangeNewCard(card: newCard)

        if(self.list.count == 0){
            list.append(newCard)
        }
        else{
            list.insert(newCard, atIndex: currentPage+1)

        }
        
        
        //list.insert(newCard, atIndex: currentPage+1)
        visualize()
        //self.cardScrollView.addSubview(newCard.cardView)
        
        newCard.cardView.alpha = 0.0
        
        UIView.animate(withDuration: 1.5, animations: {
            self.cardScrollView.addSubview(newCard.cardView)
            newCard.cardView.alpha = 1.0
        })
        
        
        if(self.list.count != 1){
            UIView.animate(withDuration: 0.7, animations: {
                self.cardScrollView.setContentOffset(CGPoint.init(x: 0, y: self.cardScrollView.contentOffset.y + self.cardScrollView.frame.height), animated: false)
            })
            
        }
        
    }
    func arrangeNewCard(card : Card){
        
        let subView = card.cardView
        subView.frame.size = CGSize.init(width: self.view.frame.width * 0.94 ,  height: self.view.frame.height * 0.94)
        subView.frame = CGRect.init(x: self.view.center.x - self.view.frame.width * 0.47, y: self.view.center.y - self.view.frame.height * 0.47 + self.view.frame.height * CGFloat(currentPage+1), width: self.view.frame.width * (0.94), height: self.view.frame.height * (0.94))
        if(self.list.count == 0){
            subView.frame = CGRect.init(x: self.view.center.x - self.view.frame.width * 0.47, y: self.view.center.y - self.view.frame.height * 0.47 + self.view.frame.height * CGFloat(currentPage), width: self.view.frame.width * (0.94), height: self.view.frame.height * (0.94))
        }
        subView.backgroundColor = UIColor.white
        subView.layer.shadowColor = UIColor.gray.cgColor
        subView.layer.shadowOpacity = 1
        subView.layer.shadowOffset = CGSize(width: -1, height: 4)
        
        //self.view.frame.width * (0.94)
        //self.view.frame.height * (0.94)
        
        let cardImage = card.imageView
        cardImage.image = #imageLiteral(resourceName: "asdfkr21")
        cardImage.frame = CGRect.init(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height * 0.7)
        cardImage.contentMode = .scaleAspectFill
        cardImage.clipsToBounds = true
        subView.addSubview(cardImage)
        
        let editButton = card.photoButton
        var origImage = #imageLiteral(resourceName: "1482738976_common-new-edit-compose-glyph")
        var tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        editButton.setImage(tintedImage, for: .normal)
        editButton.tintColor = UIColor.gray.withAlphaComponent(0.8)
        editButton.frame = CGRect.init(x: subView.frame.width-view.frame.height/10, y: subView.frame.height * 0.6, width: view.frame.height/18, height: view.frame.height/18)
        editButton.addTarget(self, action: #selector(Picker), for: .touchUpInside)
        //editButton.layer.shadowColor = UIColor.black.cgColor
        //editButton.layer.shadowOpacity = 1
        //editButton.layer.shadowOffset = CGSize(width: -1, height: 2)
        subView.addSubview(editButton)
        
        
        let textField = card.text
        textField.placeholder = " 입력해주세요 "
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.default
        textField.frame = CGRect.init(x: subView.frame.width/2-subView.frame.width * 0.35, y: subView.frame.height * 0.7 , width: subView.frame.width * 0.7, height: subView.frame.height / 10)
        subView.addSubview(textField)
        
        let doneButton = card.doneButton
        doneButton.frame = CGRect.init(x: subView.frame.width/2-subView.frame.height / 30, y: subView.frame.height * 0.8 , width: subView.frame.height / 15, height: subView.frame.height / 15)
        origImage = #imageLiteral(resourceName: "1482915612_tick")
        tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        doneButton.setImage(tintedImage, for: .normal)
        doneButton.addTarget(self, action: #selector(UploadCard), for: .touchUpInside)
        subView.addSubview(doneButton)
        
        let deleteButton = card.deleteButton
        deleteButton.frame = CGRect.init(x: subView.frame.width*0.84, y: subView.frame.height/80, width: subView.frame.height/16, height: subView.frame.height/16)
        origImage = #imageLiteral(resourceName: "1482743299_Close")
        tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        deleteButton.setImage(tintedImage, for: .normal)
        deleteButton.tintColor = UIColor.gray.withAlphaComponent(0.8)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        deleteButton.layer.shadowColor = UIColor.gray.cgColor
        deleteButton.layer.shadowOpacity = 1
        deleteButton.layer.shadowOffset = CGSize(width: -1, height: 2)
        subView.addSubview(deleteButton)
        
        
    }
    func Picker(){
        self.dismissKeyboard()
        let fusuma = FusumaViewController()
        index = currentPage;
        fusuma.delegate = self
        //fusuma.hasVideo = true // If you want to let the users allow to use video.
        self.present(fusuma, animated: true, completion: nil)
        
        
    }
    func UploadCard(){
        print("done Button pressed")
        //let uid = FIRAuth.auth()?.currentUser?.uid
        //let ref = FIRDatabase.database().reference()
        //let usersReference = ref.child("users").child(uid!)
        let upLoadThisText: String = (self.list.node(atIndex: currentPage)?.value.text.text)!
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("card_images").child("\(imageName).png")
        
        print(upLoadThisText)
        
        let resizedImage = list.node(atIndex: currentPage)?.value.imageView.image?.resizeWith(percentage: 0.1)
        if let uploadData = UIImagePNGRepresentation(resizedImage!) {
            
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                 if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    if(self.currentPage == 0){
                        self.sampleREF.child("coverCard").updateChildValues(["content" : upLoadThisText, "imageURL" : profileImageUrl], withCompletionBlock: { (err, ref) in
                            
                            if err != nil {
                                print(err!)
                                return
                            }
                            
                        })
                    }
                    else{
                        self.sampleREF.child("card\(self.currentPage!)").updateChildValues(["content" : upLoadThisText, "imageURL" : profileImageUrl], withCompletionBlock: { (err, ref) in
                            
                            if err != nil {
                                print(err!)
                                return
                            }
                            
                        })
                    }

                 
                 }
                
            })
        }
        dismissKeyboard()
        
    }
    func deleteButtonAction(){
        print("delete")
        
        let thisCard = list.node(atIndex: currentPage)?.value
        thisCard?.cardView.alpha = 1.0
        
        UIView.animate(withDuration: 1.5, animations: {
            thisCard?.cardView.alpha = 0.0
            
        })
        
        list.remove(atIndex: currentPage)
        
        UIView.animate(withDuration: 1.5, animations: {
            
            thisCard?.cardView.removeFromSuperview()
            
        })
        
        visualize()
    }
    func visualize(){
        //cardScrollView.scrollToPage(currentPage+1, animated: true, after: 0.0)
        //for i in 0..<4
        UIView.animate(withDuration: 0.5, animations: {
            for i in 0..<self.list.count {
                let currentCard = self.list.node(atIndex: i)?.value
                let subView = currentCard?.cardView
                subView?.frame = CGRect.init(x:self.view.center.x - self.view.frame.width * 0.47 , y: self.view.center.y - self.view.frame.height * 0.47 + self.view.frame.height * CGFloat(i) , width: self.view.frame.width * (0.94), height: self.view.frame.height * (0.94))
                if(i == 0){
                    currentCard?.text.placeholder = "cover card"

                }
                else{
                    currentCard?.text.placeholder = "\(i)번째 카드"
                    
                }
                
            }
        })
        
        
        cardScrollView.contentSize.height = CGFloat(list.count) * cardScrollView.frame.height
        print("list.count: ", list.count)
        
    }
    
    
    
    func setCancel(){
        cancelButton = UIButton()
        let origImage = #imageLiteral(resourceName: "1482488355_back")
        let tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        
        cancelButton.layer.shadowColor = UIColor.gray.cgColor
        cancelButton.layer.shadowOpacity = 1
        cancelButton.layer.shadowOffset = CGSize(width: 1  , height: 2)
        
        
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
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("cardScrollView.contentOffset.y = \(cardScrollView.contentOffset.y)")
        
        currentPage = Int(cardScrollView.contentOffset.y / cardScrollView.frame.height)
        print("currentPage: ", currentPage)
        
        
    }
    
    /*
    
    func secondAddButtonAction(){
        
        let offset: CGPoint = CGPoint.init(x: 0, y: cardScrollView.contentOffset.y + cardScrollView.frame.height)
        //sixthSubview(number: 5)
        self.cardScrollView.contentSize.height = self.view.frame.height * CGFloat(6)
        self.cardScrollView.setContentOffset(offset, animated: true)

    }
    func deleteThis(){
        print("first")
        self.cardScrollView.contentSize.height = self.view.frame.height * CGFloat(4)
        
        let offsetTemp: CGPoint = CGPoint.init(x: 0, y: cardScrollView.frame.height * 4)  ////////important////////////
        self.cardScrollView.setContentOffset(offsetTemp, animated: false)
        let offset: CGPoint = CGPoint.init(x: 0, y: cardScrollView.contentOffset.y - cardScrollView.frame.height)
        self.cardScrollView.setContentOffset(offset, animated: true)
        cardViews[4].removeFromSuperview()
        cardViews[5].removeFromSuperview()
        
    }
    func secondDeleteThis(){
        print("second")
        self.cardScrollView.contentSize.height = self.view.frame.height * CGFloat(5)
        
        let offsetTemp: CGPoint = CGPoint.init(x: 0, y: cardScrollView.frame.height * 5)  ////////important////////////
        self.cardScrollView.setContentOffset(offsetTemp, animated: false)
        let offset: CGPoint = CGPoint.init(x: 0, y: cardScrollView.contentOffset.y - cardScrollView.frame.height)
        self.cardScrollView.setContentOffset(offset, animated: true)
        
        cardViews[5].removeFromSuperview()
        
        
    }
    */
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editorViewController.dismissKeyboard))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

       
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        addButtonAction()  //for defaultCard
        
        
        
        self.view.backgroundColor = UIColor.white
        
        
        setCardScroll()
        self.cardScrollView.delegate = self
        self.view.addSubview(cardScrollView)
        
        setAdd()
        self.view.addSubview(addButton)
        
        setCancel()
        self.view.addSubview(cancelButton)
        
        
        
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
        
    }
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("cardScrollView.contentOffset.y = \(cardScrollView.contentOffset.y)")
        
    }
    
    

}

extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
