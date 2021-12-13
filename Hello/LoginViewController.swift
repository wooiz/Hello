//
//  LoginViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/09.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        //guard 뒤에 따라붙는 코드의 실행 결과가 true일 때 코드가 계속 실행됩니다.
        //if 구문과는 다르게 guard 구문은 항상 else 구문이 뒤에 따라와야 합니다.
       // 만약 guard 뒤 따라오는 Bool 값이 false라면 else의 블록 내부 코드를 실행하게 됩니다.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
          if let error = error {
              print("ERROR", error.localizedDescription)
            return
          }

          guard let authentication = user?.authentication,
                let idToken = authentication.idToken else { return }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { _, _ in
                self.showMainViewController()
            }
        }
    }//뷰 클라이언트 id가 구글 로그인 메서드에 전달된뒤 반환
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }// 메인 뷰 컨트롤러 이동
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailButton,googleButton,appleButton].forEach
        {
            $0?.layer.borderWidth = 1
            $0?.layer.backgroundColor = UIColor.orange.cgColor
            $0?.layer.cornerRadius = 10
            $0?.layer.borderColor = UIColor.orange.cgColor
            $0?.layer.shadowOpacity = 0.4
            $0?.layer.shadowOffset = CGSize(width: 0, height: 3)
            
            
     
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        
        //google sign in
        
    }
}
