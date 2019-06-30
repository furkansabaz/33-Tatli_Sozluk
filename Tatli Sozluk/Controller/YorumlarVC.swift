//
//  YorumlarVC.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 30.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class YorumlarVC: UIViewController {

    var secilenFikir : Fikir!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtYorum: UITextField!
    
    
    var yorumlar = [Yorum]()
    
    var fikirRef : DocumentReference!
    let fireStore = Firestore.firestore()
    var kullaniciAdi : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        fikirRef = fireStore.collection(Fikirler_REF).document(secilenFikir.documentId)
        
        if let adi = Auth.auth().currentUser?.displayName {
            kullaniciAdi = adi
        }
    }
    
    @IBAction func btnYorumEkleTapped(_ sender: Any) {
        
        guard let yorumText = txtYorum.text else {return}
        
        fireStore.runTransaction({ (transection, errorPointer) -> Any? in
            
            let secilenFikirKayit : DocumentSnapshot
            do {
                try secilenFikirKayit = transection.getDocument(self.fireStore.collection(Fikirler_REF).document(self.secilenFikir.documentId))
                
            } catch let hata as NSError{
                debugPrint("Hata Meydana Geldi : \(hata.localizedDescription)")
                return nil
            }
            
            
            
            guard let eskiYorumSayisi = (secilenFikirKayit.data()?[Yorum_Sayisi] as? Int) else { return nil}
            
            transection.updateData([Yorum_Sayisi : eskiYorumSayisi+1], forDocument: self.fikirRef)
            
            let yeniYorumRef = self.fireStore.collection(Fikirler_REF).document(self.secilenFikir.documentId).collection(YORUMLAR_REF).document()
            transection.setData([
                YORUM_TEXT : yorumText,
                Eklenme_Tarihi : FieldValue.serverTimestamp(),
                Kullanici_Adi : self.kullaniciAdi
                ], forDocument: yeniYorumRef)
            
            return nil
        }) { (nesne, hata) in
            
            if let hata = hata {
                debugPrint("Hata Meydana Geldi Transaction : \(hata.localizedDescription)")
            } else {
                self.txtYorum.text = ""
            }
            
            
        }
        
    }
    

}
extension YorumlarVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yorumlar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "YorumCell", for: indexPath) as? YorumCell {
            cell.gorunumAyarla(yorum: yorumlar[indexPath.row])
            return cell
        }
        return UITableViewCell()
        
    }
    
}
