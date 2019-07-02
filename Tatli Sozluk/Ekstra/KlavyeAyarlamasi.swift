//
//  KlavyeAyarlamasi.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 2.07.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    
    func klavyeAyarla() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(klavyeKonumAyarla(_ :)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func klavyeKonumAyarla(_ notification : NSNotification) {
        
        let sure = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
        let baslangicFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let bitisFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let farkY = bitisFrame.origin.y - baslangicFrame.origin.y
        
        UIView.animateKeyframes(withDuration: sure, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
            self.frame.origin.y += farkY
        }, completion: nil)
        
        
    }
    
}
