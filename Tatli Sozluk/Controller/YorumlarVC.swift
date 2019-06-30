//
//  YorumlarVC.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 30.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class YorumlarVC: UIViewController {

    var secilenFikir : Fikir!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtYorum: UITextField!
    
    
    var yorumlar = [Yorum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    @IBAction func btnYorumEkleTapped(_ sender: Any) {
    }
    

}
extension YorumlarVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yorumlar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "YorumCell", for: indexPath) as? YorumCell {
            cell.gorunumAyarla(yorum: yorumlar[indexPath.row])
            return cell
        }
        return UITableViewCell()
        
    }
    
}
