//
//  YorumCell.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 30.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import FirebaseAuth
class YorumCell: UITableViewCell {

    
    @IBOutlet weak var lblKullaniciAdi: UILabel!
    @IBOutlet weak var lblTarih: UILabel!
    @IBOutlet weak var lblYorum: UILabel!
    @IBOutlet weak var imgSecenekler: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    var delegate : YorumDelegate?
    var secilenYorum : Yorum!
    func gorunumAyarla(yorum : Yorum,delegate : YorumDelegate?){
        
        lblKullaniciAdi.text = yorum.kullaniciAdi
        lblYorum.text = yorum.yorumText
        
        
        let tarihFormat = DateFormatter()
        tarihFormat.dateFormat = "dd MM YYYY, hh:mm"
        let eklenmeTarihi = tarihFormat.string(from: yorum.eklenmeTarihi)
        lblTarih.text = eklenmeTarihi
        
        
        
        secilenYorum = yorum
        self.delegate = delegate
        imgSecenekler.isHidden = true
        
        
        if yorum.kullaniciId == Auth.auth().currentUser?.uid {
            imgSecenekler.isHidden = false
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(imgYorumSeceneklerPressed))
            imgSecenekler.isUserInteractionEnabled = true
            imgSecenekler.addGestureRecognizer(tap)
        }
        
        
        
    }

    @objc func imgYorumSeceneklerPressed() {
        delegate?.seceneklerYorumPressed(yorum: secilenYorum)
    }
    

}


protocol YorumDelegate {
    
    func seceneklerYorumPressed(yorum : Yorum)
}
