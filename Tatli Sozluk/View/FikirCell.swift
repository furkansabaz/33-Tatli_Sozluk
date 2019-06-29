//
//  FikirCell.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 28.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
class FikirCell: UITableViewCell {

    @IBOutlet weak var lblKullaniciAdi: UILabel!
    @IBOutlet weak var lblFikirText: UILabel!
    @IBOutlet weak var lblEklenmeTarihi: UILabel!
    @IBOutlet weak var imgBegeni: UIImageView!
    @IBOutlet weak var lblBegeniSayisi: UILabel!
    
    var secilenFikir : Fikir!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgBegeniTapped))
        imgBegeni.addGestureRecognizer(tap)
        imgBegeni.isUserInteractionEnabled = true
        
    }
    
    @objc func imgBegeniTapped() {
        
        
        //Firestore.firestore().collection(Fikirler_REF).document(secilenFikir.documentId).setData([Begeni_Sayisi : secilenFikir.begeniSayisi+1], merge: true)
        
        Firestore.firestore().document("Fikirler/\(secilenFikir.documentId!)").updateData([Begeni_Sayisi : secilenFikir.begeniSayisi+1])
    }
    
    
    
    func gorunumAyarla(fikir : Fikir) {
        
        secilenFikir = fikir
        lblKullaniciAdi.text = fikir.kullaniciAdi
        lblFikirText.text = fikir.fikirText
        lblBegeniSayisi.text = "\(fikir.begeniSayisi ?? 0)"
        
        let tarihFormat = DateFormatter()
        tarihFormat.dateFormat = "dd MM YYYY, hh:mm"
        let eklenmeTarihi = tarihFormat.string(from: fikir.eklenmeTarihi)
        lblEklenmeTarihi.text = eklenmeTarihi
        
    }

    

}
