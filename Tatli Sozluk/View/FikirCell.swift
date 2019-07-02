//
//  FikirCell.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 28.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class FikirCell: UITableViewCell {

    @IBOutlet weak var lblKullaniciAdi: UILabel!
    @IBOutlet weak var lblFikirText: UILabel!
    @IBOutlet weak var lblEklenmeTarihi: UILabel!
    @IBOutlet weak var imgBegeni: UIImageView!
    @IBOutlet weak var lblBegeniSayisi: UILabel!
    
    @IBOutlet weak var lblYorumSayisi: UILabel!
    
    @IBOutlet weak var imgSecenekler: UIImageView!
    
    var secilenFikir : Fikir!
    
    var delegate : FikirDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgBegeniTapped))
        imgBegeni.addGestureRecognizer(tap)
        imgBegeni.isUserInteractionEnabled = true
        
    }
    
    @objc func imgBegeniTapped() {
        Firestore.firestore().document("Fikirler/\(secilenFikir.documentId!)").updateData([Begeni_Sayisi : secilenFikir.begeniSayisi+1])
    }
    
    
    
    func gorunumAyarla(fikir : Fikir,delegate : FikirDelegate?) {
        
        secilenFikir = fikir
        lblKullaniciAdi.text = fikir.kullaniciAdi
        lblFikirText.text = fikir.fikirText
        lblBegeniSayisi.text = "\(fikir.begeniSayisi ?? 0)"
        
        let tarihFormat = DateFormatter()
        tarihFormat.dateFormat = "dd MM YYYY, hh:mm"
        let eklenmeTarihi = tarihFormat.string(from: fikir.eklenmeTarihi)
        lblEklenmeTarihi.text = eklenmeTarihi
        lblYorumSayisi.text = "\(fikir.yorumSayisi ?? 0)"
        
        imgSecenekler.isHidden = true
        self.delegate = delegate
        
        if fikir.kullaniciId == Auth.auth().currentUser?.uid {
            imgSecenekler.isHidden = false
            imgSecenekler.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(imgFikirSeceneklerPressed))
            imgSecenekler.addGestureRecognizer(tap)
        }
        
    }

    @objc func imgFikirSeceneklerPressed() {
        delegate?.seceneklerFikirPressed(fikir: secilenFikir)
        
    }

}

protocol FikirDelegate {
    func seceneklerFikirPressed(fikir : Fikir)
}
