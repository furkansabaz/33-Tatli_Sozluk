//
//  Uzantilar.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 4.07.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import Firebase



extension Query {
    
    
    
    func yeniWhereSorgum() -> Query {
        
        let tarihVeriler = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        
        guard let bugun = Calendar.current.date(from: tarihVeriler),
        let bitis = Calendar.current.date(byAdding: .hour, value: 24, to: bugun),
            let baslangic = Calendar.current.date(byAdding: .day, value: -2, to: bugun) else {
                fatalError("Belirtilen Tarih Aralıklarında Herhangi Bir Kayıt Bulunamadı")
        }
        
        //return whereField(Eklenme_Tarihi, isLessThanOrEqualTo: bitis).whereField(Eklenme_Tarihi, isGreaterThanOrEqualTo: baslangic).limit(to: 30)
        return whereField(Eklenme_Tarihi, isLessThanOrEqualTo: bitis).whereField(Eklenme_Tarihi, isGreaterThanOrEqualTo: bugun).limit(to: 30)
    }
    
    
}
