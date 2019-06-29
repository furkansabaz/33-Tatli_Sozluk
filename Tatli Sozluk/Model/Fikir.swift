//
//  Fikir.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 28.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import Firebase


class Fikir {
    
    private(set) var kullaniciAdi : String!
    private(set) var eklenmeTarihi : Date!
    private(set) var fikirText : String!
    private(set) var yorumSayisi : Int!
    private(set) var begeniSayisi : Int!
    private(set) var documentId : String!
    
    
    init(kullaniciAdi : String, eklenmeTarihi : Date, fikirText : String, yorumSayisi : Int, begeniSayisi : Int, documentId : String){
        
        self.kullaniciAdi = kullaniciAdi
        self.eklenmeTarihi = eklenmeTarihi
        self.fikirText = fikirText
        self.yorumSayisi = yorumSayisi
        self.begeniSayisi = begeniSayisi
        self.documentId = documentId
        
    }
    
    
    
    class func fikirGetir(snapshot : QuerySnapshot?) -> [Fikir] {
        
        var fikirler = [Fikir]()
        guard let snap = snapshot else { return fikirler}
        for document in snap.documents {
            
            let data = document.data()
            
            let kullaniciAdi = data[Kullanici_Adi] as? String ?? "Misafir"
            
            let ts = data[Eklenme_Tarihi] as? Timestamp ?? Timestamp()
            let eklenmeTarihi = ts.dateValue()
            
            let fikirText = data[Fikir_Text] as? String ?? ""
            let yorumSayisi = data[Yorum_Sayisi] as? Int ?? 0
            let begeniSayisi = data[Begeni_Sayisi] as? Int ?? 0
            let documentId = document.documentID
            
            let yeniFikir = Fikir(kullaniciAdi: kullaniciAdi, eklenmeTarihi: eklenmeTarihi, fikirText: fikirText, yorumSayisi: yorumSayisi, begeniSayisi: begeniSayisi, documentId: documentId)
            fikirler.append(yeniFikir)
            
        }
        return fikirler
        
    }
    
}
