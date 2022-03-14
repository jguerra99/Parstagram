//
//  SignUpViewController.swift
//  Parstagram
//
//  Created by Jose Lopez on 3/13/22.
//
import Foundation
import UIKit
import Parse

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var SignUp: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var eMail: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
        
        } else {
             // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func SignedUp(_ sender: Any) {
    var user = PFUser()
    user.username = usernameField.text
    user.password = passwordField.text
        user["firstname"] = firstName.text
        user["lastname"] = lastName.text
        user.email = eMail.text
    user.signUpInBackground{ (success, error) in
        if success{
            UserDefaults.standard.set(true, forKey: "userloggedIn")
            self.performSegue(withIdentifier: "ViewSegue", sender: nil)
        }else {
            print("Error")
        }
        
    }
    }
    
    

    
    @IBAction func LogIn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

