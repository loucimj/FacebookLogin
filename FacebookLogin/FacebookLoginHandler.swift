//
//  FacebookLoginHandler.swift
//  FacebookLogin
//
//  Created by Javier Loucim on 1/8/17.
//  Copyright © 2017 Javier Loucim. All rights reserved.
//


/* ------------------------------------------------------------------------------------
//Add following lines to your UIViewController

 @IBOutlet weak var loginButton: FBSDKLoginButton!
 
    func viewDidLoad() {
        super.viewDidLoad()

        FacebookData.shared.loginButton = self.loginButton
        FacebookData.shared.delegate = self
    }

extension ViewController: FacebookLoginHandler {
    func facebookUserHasLoggedIn(user: FacebookUser) {
        print (user)
    }
}

 
------------------------------------------------------------------------------------ */

import Foundation
import FBSDKLoginKit

struct FacebookUser {
    var firstName:String = ""
    var lastName:String = ""
    var email:String = ""
    var birthday:String = ""
    var gender:String = ""
    var isVerified:Bool = false
    var thirdPartyID:String?
    var url:String?
}



class FacebookData: NSObject, FBSDKLoginButtonDelegate {
    static var shared = FacebookData()
    var readPermissions = ["user_friends", "public_profile","email"]
    var delegate: FacebookLoginHandler?
    
    var loginButton:FBSDKLoginButton?  {
        didSet {
            loginButton?.delegate = self
            loginButton?.readPermissions = readPermissions
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "first_name, email, third_party_id, gender, birthday, last_name, picture.type(large)"]).start(completionHandler: { connection, result, error  in
            
            guard error == nil else {
                print("\(error)")
                return
            }
            if let data = result as? Dictionary<String, Any> {
                
                var user = FacebookUser()
                user.firstName = data["first_name"] as? String ?? ""
                user.lastName = data["last_name"] as? String ?? ""
                user.email = data["email"] as? String ?? ""
                user.thirdPartyID = data["third_party_id"] as? String
                user.gender = data["gender"] as? String ?? ""
                user.isVerified = data["is_verified"] as? Bool ?? false
                user.birthday = data["birthday"] as? String ?? ""
                
                if let picture = data["picture"] as? Dictionary<String,Any> {
                    if let pictureData = picture["data"] as? Dictionary<String,Any>  {
                        if let url = pictureData["url"] as? String {
                            user.url = url
                        }
                    }
                }
                
                self.delegate?.facebookUserHasLoggedIn(user: user)
            }
            
            
            
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
}

protocol FacebookLoginHandler {
    func facebookUserHasLoggedIn(user: FacebookUser)
}

