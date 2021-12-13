//
//  NewViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/13.
//

import UIKit
import FirebaseAuth

class NewViewController: UIViewController{
    
    
    @IBOutlet weak var newLoginButton: UIButton!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newLoginButton.layer.cornerRadius = 10
        newLoginButton.layer.shadowOpacity = 0.4
        newLoginButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        
    }
    
    
    @IBAction func newLoginButtonTapped(_ sender: UIButton) {
        
        let email = emailText.text ?? ""
        let password = passwordText.text ?? ""
        
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password){
            [weak self] authResult, error in
            guard let self = self else {return}
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일때
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessage.text = error.localizedDescription
                }
            }
            
            else{
                self.showMainViewController()
            }
            
            
        }
        
    }
    
    private func loginUser(withEmail email: String , password: String){
        Auth.auth().signIn(withEmail: email, password: password){
            [weak self]_, error in
            guard let self = self else {return}
            
            if let error = error{
                self.errorMessage.text = error.localizedDescription
            }
            else{
                self.showMainViewController()
            }
        }
    }
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    
}
