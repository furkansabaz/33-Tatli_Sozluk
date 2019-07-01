//
//  Yorum.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 30.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import Firebase


class Yorum {
    
    private(set) var kullaniciAdi : String!
    private(set) var eklenmeTarihi : Date!
    private(set) var yorumText : String!
    
    
    init(kullaniciAdi : String, eklenmeTarihi : Date, yorumText : String) {
        self.kullaniciAdi = kullaniciAdi
        self.eklenmeTarihi = eklenmeTarihi
        self.yorumText = yorumText
    }
    
    
    class func yorumlariGetir(snapshot : QuerySnapshot?) -> [Yorum] {
        
        var yorumlar = [Yorum]()
        
        guard let snap = snapshot else { return yorumlar}
        
        
        for kayit in snap.documents {
            
            
            let veri = kayit.data()
            
            let kullaniciAdi = veri[KULLANICI_ADI] as? String ?? "Misafir"
            
            let ts = veri[Eklenme_Tarihi] as? Timestamp ?? Timestamp()
            let eklenmeTarihi = ts.dateValue()
            
            let yorumText = veri[YORUM_TEXT] as? String ?? "Yorum Yok."
            let yeniYorum = Yorum(kullaniciAdi: kullaniciAdi, eklenmeTarihi: eklenmeTarihi, yorumText: yorumText)
            
            yorumlar.append(yeniYorum)
            
        }
        
        
        return yorumlar
    }
    
    
}
