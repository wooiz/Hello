//
//  CardListViewController.swift
//  Hello
//
//  Created by 최진우 on 2021/12/14.
//

import UIKit
import Kingfisher
import FirebaseDatabase
class CardListViewController: UITableViewController{
    var ref: DatabaseReference! //Firebase Realtime Database
    
    var creditCardList: [CreditCard] = []//리스트 셀에 보여줄 글
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibname = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibname, forCellReuseIdentifier: "CardListCell")
     
        
        ref = Database.database().reference()
        
        ref.observe(.value) {snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else {return}
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted{
                    $0.kcal < $1.kcal
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch let error{
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count // 테이블의 row 수
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀에 들어갈 데이터 지정
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else {return UITableViewCell()}
            
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].kcal)kcal"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL) // 킹피셔 이용 이미지 불러오기
        
        
        return cell
    }
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //상세화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else {return}
        
        detailViewController.creditcard = creditCardList[indexPath.row];
        self.show(detailViewController, sender: nil)
        
        let cardID = creditCardList[indexPath.row].id
        ref.child("Item\(cardID)/isSelected").setValue(true)
    }
    
    
    
    
}
