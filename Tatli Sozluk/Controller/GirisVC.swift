//
//  GirisVC.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 30.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func btnHesapOlusturPressed(_ sender: Any) {
    }
    

}
