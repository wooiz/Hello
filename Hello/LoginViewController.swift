//
//  LoginViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/09.
//

import UIKit


class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailButton,googleButton,appleButton].forEach
        {
            $0?.layer.borderWidth = 1
            $0?.layer.backgroundColor = UIColor.orange.cgColor
            $0?.layer.cornerRadius = 10
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
}
