//
//  FikirEkleVC.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 23.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class FikirEkleVC: UIViewController {

    
    @IBOutlet weak var sgmntKategoriler: UISegmentedControl!
    
    @IBOutlet weak var txtKullaniciAdi: UITextField!
    
    @IBOutlet weak var txtFikir: UITextView!
    
    @IBOutlet weak var btnPaylas: UIButton!
    
    
    let placeholderText = "Fikrinizi Belirtin..."
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnPaylas.layer.cornerRadius = 5
        txtFikir.layer.cornerRadius = 7
        
        txtFikir.text = placeholderText
        txtFikir.textColor = .lightGray
        txtFikir.delegate = self
        
    }
    

    @IBAction func sgmntKategoriDegisti(_ sender: Any) {
    }
    
    @IBAction func btnPaylasPressed(_ sender: Any) {
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
