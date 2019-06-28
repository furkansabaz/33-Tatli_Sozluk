//
//  ViewController.swift
//  Tatli Sozluk
//
//  Created by Furkan Sabaz on 21.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class AnaVC: UIViewController {

    @IBOutlet weak var sgmntKategoriler: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var fikirler =  [Fikir]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }


}


extension AnaVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fikirler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FikirCell", for: indexPath) as? FikirCell {
            cell.gorunumAyarla(fikir: fikirler[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
}
