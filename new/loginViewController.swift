//
//  loginViewController.swift
//  blink12_01
//
//  Created by 한민규 on 2016. 12. 4..
//  Copyright © 2016년 Blink. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class loginViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    var logInButton = FBSDKLoginButton()
    let imageName = "KakaoTalk_Photo_2016-12-02-16-57-29.jpg"
    var image: UIImage!
    var imageView : UIImageView!
    
    func setImage(){
        image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        
        imageView.frame = view.frame
        imageView.center = view.center
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
    }
    
    func setLoginButton(){
        logInButton = FBSDKLoginButton()
        logInButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        logInButton.center = self.view.center
        logInButton.readPermissions = ["email", "public_profile", "user_friends","user_birthday","user_education_history"]
        logInButton.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setLoginButton()
        view.addSubview(imageView)
        view.addSubview(logInButton)
        
    
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print("Did log out of facebook")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Successfully logged in with facebook...")
        
        
        self.dismiss(animated: true, completion: nil)
       
        self.loginFIR()
        
        
        
    }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func loginFIR() {
        
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        var uid : String? = "sss"
         
        
        FIRAuth.auth()?.signIn(with: credentials) { (user, error) in
            // ...
            print("FireAuth start")
            if let error = error {
                print("Something went wrong with our FB user: ", error )
                return
            }
            print("Successfully logged in with our user: ", user ?? "")
            uid = (user?.uid)!
            
            if(uid == nil){
                print("uid is Nil")
            }
            else{
                print("uid was \(uid!)")
                self.getInfo()
            }
            
        }
        
        
    }
    
    func getInfo(){
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, friends, birthday, education"]).start { (connection, result, err)in
    
            if err != nil {
                print("Failed to start graph request:", err!)
                return
            }
    
            print(result!)
    
            let dict = result as! NSDictionary
            
            print("name:", dict["name"]!)
            let values = ["name": dict["name"]!, "email": dict["email"]!, "friend_Number": ((dict["friends"] as! NSDictionary)["summary"] as! NSDictionary)["total_count"]!]
    
            let uid = FIRAuth.auth()?.currentUser?.uid
            
            print("uid is \(uid!)")
    
    
    
            self.registerUserIntoDatabaseWithUID(uid!, values: values as [String : Any] )
            
    
        }
    
    /////////////////////////////////////////////////////////////////////////////
    
    //let uid = FIRAuth.auth()?.currentUser?.uid
    
    //print("uid: \(uid!)")
    
    
    /////////////////////////////////////////////////////////////////////////////
    
    
        
        
    
    
    }
    
    func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: Any]) {
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
        })
    }

    
}
