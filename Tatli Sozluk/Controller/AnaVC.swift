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
    private var fikirlerListener : ListenerRegistration!
    
    private var secilenKategori = Kategoriler.Eglence.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        fikirlerCollectionRef = Firestore.firestore().collection(Fikirler_REF)
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        setListener()
       
        
    }
    
    func setListener() {
        fikirlerListener = fikirlerCollectionRef.whereField(KATEGORI, isEqualTo: secilenKategori)
            .order(by: Eklenme_Tarihi, descending: true)
            .addSnapshotListener { (snapshot, error) in
            if let error = error {
                debugPrint("Kayıtları Getirirken Hata Meydana Geldi : \(error.localizedDescription)")
            } else {
                self.fikirler.removeAll()
                guard let snap = snapshot else { return}
                for document in snap.documents {
                    
                    let data = document.data()
                    
                    let kullaniciAdi = data[Kullanici_Adi] as? String ?? "Misafir"
                    
                    let ts = data[Eklenme_Tarihi] as? Timestamp ?? Timestamp()
                    let eklenmeTarihi = ts.dateValue()
                    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        fikirlerListener.remove()
    }

    
    @IBAction func kategoriChanged(_ sender: Any) {
        
        switch sgmntKategoriler.selectedSegmentIndex {
        case 0 :
            secilenKategori = Kategoriler.Eglence.rawValue
        case 1 :
            secilenKategori = Kategoriler.Absurt.rawValue
        case 2 :
            secilenKategori = Kategoriler.Gundem.rawValue
        case 3 :
            secilenKategori = Kategoriler.Populer.rawValue
        default :
            secilenKategori = Kategoriler.Eglence.rawValue
        }
        fikirlerListener.remove()
        setListener()
    
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
    
}
