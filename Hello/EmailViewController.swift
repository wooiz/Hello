//
//  EmailViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/10.
//

import UIKit

class EmailViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
        loginButton.layer.cornerRadius = 10
        
        loginButton.isEnabled = false
        
        emailText.delegate = self
        passwordText.delegate = self
        
        emailText.becomeFirstResponder()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        
    }
    
    
    
}

extension EmailViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let emailEmpty = emailText.text == ""
        let passwordEmpty = passwordText.text == ""
        
        loginButton.isEnabled = !emailEmpty && !passwordEmpty
        
    }
}
