//
//  FikirCell.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 28.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class FikirCell: UITableViewCell {

    @IBOutlet weak var lblKullaniciAdi: UILabel!
    @IBOutlet weak var lblFikirText: UILabel!
    @IBOutlet weak var lblEklenmeTarihi: UILabel!
    @IBOutlet weak var imgBegeni: UIImageView!
    @IBOutlet weak var lblBegeniSayisi: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func gorunumAyarla(fikir : Fikir) {
        
        lblKullaniciAdi.text = fikir.kullaniciAdi
        lblFikirText.text = fikir.fikirText
        lblBegeniSayisi.text = "\(fikir.begeniSayisi ?? 0)"
        
        let tarihFormat = DateFormatter()
        tarihFormat.dateFormat = "dd MM YYYY, hh:mm"
        let eklenmeTarihi = tarihFormat.string(from: fikir.eklenmeTarihi)
        lblEklenmeTarihi.text = eklenmeTarihi
        
    }

    

}
