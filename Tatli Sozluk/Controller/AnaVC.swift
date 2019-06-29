//
//  ViewController.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 21.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
class AnaVC: UIViewController {

    @IBOutlet weak var sgmntKategoriler: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var fikirler =  [Fikir]()
    
    
    private var fikirlerCollectionRef : CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.estimatedRowHeight = 80
        //tableView.rowHeight = UITableView.automaticDimension
        
        fikirlerCollectionRef = Firestore.firestore().collection(Fikirler_REF)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        fikirlerCollectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                debugPrint("Kayıtları Getirirken Hata Meydana Geldi : \(error.localizedDescription)")
            } else {
                guard let snap = snapshot else { return}
                for document in snap.documents {
                    
                    let data = document.data()
                    
                    let kullaniciAdi = data[Kullanici_Adi] as? String ?? "Misafir"
                    let eklenmeTarihi = data[Eklenme_Tarihi] as? Date ?? Date()
                    let fikirText = data[Fikir_Text] as? String ?? ""
                    let yorumSayisi = data[Yorum_Sayisi] as? Int ?? 0
                    let begeniSayisi = data[Begeni_Sayisi] as? Int ?? 0
                    let documentId = document.documentID
                    
                    let yeniFikir = Fikir(kullaniciAdi: kullaniciAdi, eklenmeTarihi: eklenmeTarihi, fikirText: fikirText, yorumSayisi: yorumSayisi, begeniSayisi: begeniSayisi, documentId: documentId)
                    self.fikirler.append(yeniFikir)
                    
                }
                self.tableView.reloadData()
            }
            
        }
    }

}


extension AnaVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fikirler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FikirCell", for: indexPath) as? FikirCell {
            cell.gorunumAyarla(fikir: fikirler[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
