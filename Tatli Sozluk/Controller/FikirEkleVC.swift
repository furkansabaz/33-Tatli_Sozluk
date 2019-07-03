//
//  FikirEkleVC.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 23.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
class FikirEkleVC: UIViewController {

    
    @IBOutlet weak var sgmntKategoriler: UISegmentedControl!
    
    @IBOutlet weak var txtKullaniciAdi: UITextField!
    
    @IBOutlet weak var txtFikir: UITextView!
    
    @IBOutlet weak var btnPaylas: UIButton!
    
    
    let placeholderText = "Fikrinizi Belirtin..."
    
    var secilenKategori = Kategoriler.Eglence.rawValue
    
    var kullaniciAdi : String = "Misafir"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnPaylas.layer.cornerRadius = 5
        txtFikir.layer.cornerRadius = 7
        
        txtFikir.text = placeholderText
        txtFikir.textColor = .lightGray
        txtFikir.delegate = self
        
        txtKullaniciAdi.isEnabled = false
        
        if let adi = Auth.auth().currentUser?.displayName {
            kullaniciAdi = adi
            txtKullaniciAdi.text = kullaniciAdi
        }
        
    }
    

    @IBAction func sgmntKategoriDegisti(_ sender: Any) {
        
        switch sgmntKategoriler.selectedSegmentIndex {
        case 0 :
            secilenKategori = Kategoriler.Eglence.rawValue
        case 1 :
            secilenKategori = Kategoriler.Absurt.rawValue
        case 2 :
            secilenKategori = Kategoriler.Gundem.rawValue
        default :
            secilenKategori = Kategoriler.Eglence.rawValue
        }
        
    }
    
    @IBAction func btnPaylasPressed(_ sender: Any) {
        guard  txtFikir.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty != true else {return}
        
        Firestore.firestore().collection(Fikirler_REF).addDocument(data: [
            KATEGORI : secilenKategori,
            Begeni_Sayisi : 0,
            Yorum_Sayisi : 0,
            Fikir_Text : txtFikir.text!,
            Eklenme_Tarihi : FieldValue.serverTimestamp(),
            Kullanici_Adi : kullaniciAdi,
            KULLANICI_ID : Auth.auth().currentUser?.uid ?? ""
        ]) { (hata) in
            
            if let hata = hata {
                print("Document Hatası : \(hata.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        
    }
    
    

}

extension FikirEkleVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .darkGray
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            txtFikir.text = placeholderText
            txtFikir.textColor = .lightGray
        }
        
    }
    
    
}
