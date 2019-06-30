//
//  GirisVC.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 30.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import FirebaseAuth
class GirisVC: UIViewController {
    
    @IBOutlet weak var txtEmailAdresi: UITextField!
    
    @IBOutlet weak var txtParola: UITextField!
    @IBOutlet weak var btnGirisYap: UIButton!
    @IBOutlet weak var btnHesapOlustur: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        btnGirisYap.layer.cornerRadius = 10
        btnHesapOlustur.layer.cornerRadius = 10
        
    }
    
    
    @IBAction func btnGirisYapPressed(_ sender: Any) {
        
        guard let emailAdresi = txtEmailAdresi.text,
            let parola = txtParola.text else { return }
        
        Auth.auth().signIn(withEmail: emailAdresi, password: parola) { (kullanici,hata) in
            
            if let hata = hata {
                debugPrint("Oturum Açarken Hata Meydana Geldi : \(hata.localizedDescription)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    
    

}
