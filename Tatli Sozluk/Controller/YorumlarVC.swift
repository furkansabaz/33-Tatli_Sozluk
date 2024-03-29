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
    
    var yorumlarListener : ListenerRegistration!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        fikirRef = fireStore.collection(Fikirler_REF).document(secilenFikir.documentId)
        
        if let adi = Auth.auth().currentUser?.displayName {
            kullaniciAdi = adi
        }
        
        self.view.klavyeAyarla()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        yorumlarListener = fireStore.collection(Fikirler_REF).document(secilenFikir.documentId).collection(YORUMLAR_REF)
            .order(by: Eklenme_Tarihi, descending: false)
            .addSnapshotListener({ (snapshot, hata) in
                
                guard let snapshot = snapshot else {
                    debugPrint("Yorumları Getirirken Hata Meydana Geldi : \(hata?.localizedDescription)")
                    return
                }
                
                self.yorumlar.removeAll()
                self.yorumlar = Yorum.yorumlariGetir(snapshot: snapshot)
                self.tableView.reloadData()
            })
        
    }
    
    @IBAction func btnYorumEkleTapped(_ sender: Any) {
        
        guard let yorumText = txtYorum.text, txtYorum.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty != true else {return}
        
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
                Kullanici_Adi : self.kullaniciAdi,
                KULLANICI_ID : Auth.auth().currentUser?.uid ?? ""
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "YorumDuzenleSegue" {
            
            if let hedefVC = segue.destination as? YorumDuzenleVC {
                
                if let yorumVeri = sender as? (secilenYorum: Yorum, secilenFikir : Fikir) {
                    
                    hedefVC.yorumVerisi = yorumVeri
                }
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
            cell.gorunumAyarla(yorum: yorumlar[indexPath.row],delegate:  self)
            return cell
        }
        return UITableViewCell()
        
    }
    
}


extension YorumlarVC : YorumDelegate {
    func seceneklerYorumPressed(yorum: Yorum) {
        
        
        let alert = UIAlertController(title: "Yorumu Düzenle", message: "Yorumunuzu düzenleyebilir veya silebilirsiniz", preferredStyle: .actionSheet)
        
        let silAction = UIAlertAction(title: "Yorumu Sil", style: .default) { (action) in
//            self.fireStore.collection(Fikirler_REF)
//                    .document(self.secilenFikir.documentId)
//                .collection(YORUMLAR_REF).document(yorum.documentId).delete(completion: { (hata) in
//                    if let hata = hata {
//                        debugPrint("Yorumu Silerken Hata Meydana Geldi : \(hata.localizedDescription)")
//                    } else {
//                        alert.dismiss(animated: true, completion: nil)
//                    }
//                })
        
        
            self.fireStore.runTransaction({ (transaction, hata) -> Any? in
                
                
                let secilenFikirKayit : DocumentSnapshot
                
                do {
                    try secilenFikirKayit = transaction.getDocument(self.fireStore.collection(Fikirler_REF).document(self.secilenFikir.documentId))
                    
                } catch let hata as NSError {
                    debugPrint("Fikir Bulunamadı : \(hata.localizedDescription)")
                    return nil
                }
                
                
                guard let eskiYorumSayisi = (secilenFikirKayit.data()?[Yorum_Sayisi] as? Int) else { return nil}
                
                transaction.updateData([Yorum_Sayisi : eskiYorumSayisi-1], forDocument: self.fikirRef)
                
                
                let silincekYorumRef = self.fireStore.collection(Fikirler_REF).document(self.secilenFikir.documentId).collection(YORUMLAR_REF).document(yorum.documentId)
                transaction.deleteDocument(silincekYorumRef)
                return nil
            }) { (nesne,hata) in
                
                if let hata = hata {
                    debugPrint("Yorum Silerken Hata Meydana Geldi : \(hata.localizedDescription)")
                } else {
                    alert.dismiss(animated: true, completion: nil)
                }
                
            }
        
        
        
        
        
        }
        
        let duzenleAction = UIAlertAction(title: "Yorumu Düzenle", style: .default) { (action) in
            //yorum düzenlenecek
            
            self.performSegue(withIdentifier: "YorumDuzenleSegue", sender: (yorum,self.secilenFikir))
            self.dismiss(animated: true, completion: nil)
        }
        let iptalAction = UIAlertAction(title: "İptal Et", style: .cancel, handler: nil)
        
        
        alert.addAction(silAction)
        alert.addAction(duzenleAction)
        alert.addAction(iptalAction)
        present(alert, animated: true, completion: nil)
        
        
        
    }
}
