//
//  EmailViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/10.
//

import UIKit
import FirebaseAuth


class EmailViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigation bar 보이기
        navigationController?.navigationBar.isHidden = false
        
        loginButton.layer.cornerRadius = 10
        
        loginButton.isEnabled = false
        
        emailText.delegate = self
        passwordText.delegate = self
        
        emailText.becomeFirstResponder()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        //firebase 이메일 비밀번호인증
        let email = emailText.text ?? ""
        let password = passwordText.text ?? ""
        
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password){
            [weak self] authResult, error in
            guard let self = self else {return}
            
            self.showMainViewController()
            
        }
        
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
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
