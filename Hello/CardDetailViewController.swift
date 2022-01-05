//
//  CardDetailViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/15.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController{
    var creditcard: CreditCard?
    
    @IBOutlet weak var lottieView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "food")
        lottieView.contentMode = .scaleAspectFit
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop
        animationView.play()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let detail = creditcard else {return}
        
        titleLabel.text = """
        \(detail.name)는 \(detail.kcal)kcal 입니다
        """
        
        
        foodLabel.text = detail.name
        kcalLabel.text = detail.kcalDetail
        informationLabel.text = detail.information
        
    }
}
