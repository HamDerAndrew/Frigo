//
//  LoginViewController.swift
//  Frigo
//
//  Created by André Larsen on 28/01/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Allow a user to dismiss the keyboard by pressing anywhere on the screen
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        //Add delegate for the UITextFieldDelegate
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito", size: 20)!], for: .normal)
        loginBtn.layer.cornerRadius = 8.0
        
    }
    
    //Hide the top navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if(emailTextField.text == "hoc@hoc.io" && passwordTextField.text == "123") {
            performSegue(withIdentifier: "toProducts", sender: self)
        } else if(emailTextField.text != "hoc@hoc.io" && passwordTextField.text != "123") {
            let alert = UIAlertController(title: "Login fejl", message: "Forkert brugernavn og/eller password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //dismiss keyboard when pressing "Retur"
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
}
