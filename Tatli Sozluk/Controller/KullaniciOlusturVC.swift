//
//  KullaniciOlusturVC.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 30.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class KullaniciOlusturVC: UIViewController {

    
    @IBOutlet weak var txtEmailAdresi: UITextField!
    
    @IBOutlet weak var txtParola: UITextField!
    
    @IBOutlet weak var btnVazgectim: UIButton!
    @IBOutlet weak var txtKullaniciAdi: UITextField!
    @IBOutlet weak var btnHesapOlustur: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         btnVazgectim.layer.cornerRadius = 10
        btnHesapOlustur.layer.cornerRadius = 10
    }
    
    @IBAction func btnHesapOlusturPressed(_ sender: Any) {
    }
    
    @IBAction func btnVazgectimPressed(_ sender: Any) {
    }
    
}
