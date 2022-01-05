//
//  MainViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/10.
//

import UIKit
import FirebaseAuth



class MainViewController : UIViewController{
   
    var buttondata:ImageCell?
    @IBOutlet weak var phraseText: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var imageName = ["running.jpg" , "food.jpg" , "note.jpg", "youtube.jpg"]
    var nameImage = ["운동 알림" , "음식 칼로리", "다이어트 다이어리" , "유튜브" ]
    let PhraseText = [phrace(phracetext: "그 무엇에도 한계를 둘 수 없다 - 마이클 펠프스"),
                      phrace(phracetext: "바로 오늘 당신의 삶 100%가 남아있다 - 톰 랜드리"),
                      phrace(phracetext: "끝날 때까지 끝난게 아니다 - 요기 베라"),
                      phrace(phracetext: "성공은 준비와 기회가 만나는 곳이다 - 바비 언저"),
                      phrace(phracetext: "실패가 두려운 자는 성공할 자격이 없다 - 찰스 바클리"),
                      phrace(phracetext: "오늘 할 수 있는 일에만 전력을 쏟으라  - 뉴튼"),
                      phrace(phracetext: "성공은 수고의 대가라는 것을 기억하라 - 소포클레스"),
                      phrace(phracetext: "자기 신뢰가 성공의 제1의 비결이다 - 에머슨"),
                      phrace(phracetext: "나약한 태도는 성격도 나약하게 한다 - 아인슈타인"),
                      phrace(phracetext: "성공은 매일 반복한 작은 노력들의 합이다 - 로버트 콜리어")]
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var hiLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
  
       
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.navigationBar.isHidden = true
       
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
      collectionView.addGestureRecognizer(tapGesture)
        
        
            
        
    }
    
    @objc func touchToPickPhoto() {
        guard let cardlistviewcontroller = self.storyboard?.instantiateViewController(identifier: "CardListViewController") as? CardListViewController else {return}
      let random = Int(arc4random_uniform(10))
      let phrasetext = PhraseText[random]
        self.phraseText.text = phrasetext.phracetext
        
       
        
    }
    
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
        
        navigationController?.navigationBar.isHidden = true
        
        
        let displayName = Auth.auth().currentUser?.email ?? ""
        
        
        
        
        
        
        
        let isEmailSignin = Auth.auth().currentUser?.providerData[0].providerID == "password" //로그인을 이메일로 했는지 판단
        
      
    }
    
    
    
    
    
    
}


extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {return UICollectionViewCell()  }
        
        
        let img = UIImage(named: "\(imageName[indexPath.row])")
                cell.uiImageView?.image = img
       
                return cell
       
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageName.count   }
    
    
    }





extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    //셀의 사이즈를 설정 표시할 사이즈를 cgsize로 구현 아이폰화면의 2분의 1을 한다
}








