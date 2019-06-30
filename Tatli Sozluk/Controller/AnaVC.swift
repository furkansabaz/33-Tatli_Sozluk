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
import FirebaseAuth
class AnaVC: UIViewController {

    @IBOutlet weak var sgmntKategoriler: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var fikirler =  [Fikir]()
    
    
    private var fikirlerCollectionRef : CollectionReference!
    private var fikirlerListener : ListenerRegistration!
    private var secilenKategori = Kategoriler.Eglence.rawValue
    private var listenerHandle : AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        fikirlerCollectionRef = Firestore.firestore().collection(Fikirler_REF)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if fikirlerListener != nil {
            fikirlerListener.remove()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        listenerHandle = Auth.auth().addStateDidChangeListener({ (auth, user)in
            
            if user == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let girisVC = storyboard.instantiateViewController(withIdentifier: "GirisVC")
                self.present(girisVC, animated: true, completion: nil)
            } else {
                self.setListener()
            }
        })
        
        
       
        
    }
    
    func setListener() {
        
        if secilenKategori == Kategoriler.Populer.rawValue {
            
            fikirlerListener = fikirlerCollectionRef
                .order(by: Eklenme_Tarihi, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let error = error {
                        debugPrint("Kayıtları Getirirken Hata Meydana Geldi : \(error.localizedDescription)")
                    } else {
                        self.fikirler.removeAll()
                        self.fikirler = Fikir.fikirGetir(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
                    
            }
        } else {
            fikirlerListener = fikirlerCollectionRef.whereField(KATEGORI, isEqualTo: secilenKategori)
                .order(by: Eklenme_Tarihi, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let error = error {
                        debugPrint("Kayıtları Getirirken Hata Meydana Geldi : \(error.localizedDescription)")
                    } else {
                        self.fikirler.removeAll()
                        self.fikirler = Fikir.fikirGetir(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
                    
            }
        }
        
        
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
    
    @IBAction func btnOturumKapatPressed(_ sender: Any) {
         let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch  let oturumHatasi as NSError {
            debugPrint("Oturum Kapatılırken Hata Meydana Geldi : \(oturumHatasi.localizedDescription)")
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
    
}
