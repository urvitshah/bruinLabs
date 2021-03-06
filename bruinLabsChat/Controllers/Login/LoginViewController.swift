//
//  LoginViewController.swift
//  bruinLabsChat
//
//  Created by Reema Kshetramade on 7/26/20.
//  Copyright © 2020 Reema Kshetramade. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
//        title = "Log In"
        
        loginButton.layer.cornerRadius = 10.0
        signUpButton.layer.cornerRadius = 10.0
        errorLabel.alpha = 0
        
    }
    
   // @objc private func didTapSignUp() {
     //   let vc = RegisterViewController()
       // vc.title = "Create an account"
       // navigationController?.pushViewController(vc, animated: true)
   // }
    
    
    @IBAction func didTapLogin(_ sender: Any) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
//            errorLabel.text = "Please enter all fields."
//            errorLabel.alpha = 1
            
            let alert = UIAlertController(title: "oops!", message: "please enter all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
        
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    let alert = UIAlertController(title: "oops!", message: "email or password entered in incorrect", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "try again", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
                
                else {
//                    let user = result!.user
                    UserDefaults.standard.set(email, forKey: "email")
                    let safeEmail = DatabaseManager.safeEmail(email: email)
                    let username = DatabaseManager.shared.getUsername(email: safeEmail)
                    UserDefaults.standard.set(username, forKey: "username")
                    print("user defaults: \(email), \(username)")
//                    self.navigationController?.dismiss(animated: true, completion: nil)
//                    self.navigationController?.pushViewController(ConversationsViewController(), animated: true)
//                    self.navigationController?.dismiss(animated: true, completion: {
//                        print("dismissed login screen")
//                    })
//                    self.navigationController?.popToRootViewController(animated: false)
//                    self.navigationController?.pushViewController(ConversationsViewController(), animated: true)
                    let convVC = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
                    let nav = UINavigationController(rootViewController: convVC)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true)
                    
                }
            }
            
        }
        
        
        
        

    }
    

    @IBAction func didTapSignUp(_ sender: Any) {
//        let regVC = self.storyboard?.instantiateViewController(withIdentifier: "registerVC") as! RegisterViewController
        let regVC = RegisterViewController()
        navigationController?.pushViewController(regVC, animated: true)
    }
    
    
}
