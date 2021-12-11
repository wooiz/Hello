//
//  MainViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/10.
//

import UIKit
import FirebaseAuth


class MainViewController : UIViewController{
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var hiLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        hiLabel.text = """
       환영합니다
       \(email)님
       """
        
        let isEmailSignin = Auth.auth().currentUser?.providerData[0].providerID == "password" //로그인을 이메일로 했는지 판단
        
        resetPasswordButton.isHidden = !isEmailSignin
    }
    
    
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }
        catch let signOutError as NSError{
            print("Error : sign Out \(signOutError.localizedDescription)")
        }
        
      
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? "" // ?? 옵셔널 값의 값이 없다면 오른쪽값
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    
}
