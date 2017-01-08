//
//  ViewController.swift
//  FacebookLogin
//
//  Created by Javier Loucim on 1/7/17.
//  Copyright © 2017 Javier Loucim. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        FacebookData.shared.loginButton = self.loginButton
        FacebookData.shared.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: FacebookLoginHandler {
    func facebookUserHasLoggedIn(user: FacebookUser) {
        print (user)
    }
}


//extension ViewController: FBSDKLoginButtonDelegate {
//    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "first_name, last_name, picture.type(large)"]).start(completionHandler: { connection, result, error  in
//            
//            guard error == nil else {
//                return
//            }
//            if let data = result as? Dictionary<String, Any> {
//                print (data["first_name"] as? String ?? "")
//                print (data["last_name"] as? String ?? "")
//                print (data["email"] as? String ?? "")
//                if let picture = data["picture"] as? Dictionary<String,Any> {
//                    if let pictureData = picture["data"] as? Dictionary<String,Any>  {
//                        if let url = pictureData["url"] as? String {
//                            print (url)
//                        }
//                    }
//                }
//            }
//            
//            
//            
//        })
//    }
//    
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        
//    }
//    
//    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
//        return true
//    }
//    
//    
//}
