//
//  FavoriteAmiibosListViewController.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import UIKit
import Foundation
import Kingfisher

class FavoriteAmiibosListViewController: UIViewController {
    
    @IBOutlet weak var emptyList: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var amiiboList: [Amiibo] = []
    let server = ApiCalls()
    
    let router = AmiiboRouting()
    let filterClass = FilterAmiibos()
    
    // Returning the xib file after instantiating it
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AmiiboCell", bundle: nil), forCellReuseIdentifier: "AmiiboCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.emptyList.text = "¡Añade tus Amiibos favoritos!"
        self.emptyList.textColor = UIColor(named: "Pink")
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = true
            self.amiiboList = RealmDatabaseRepository.shared().getAmiibos()
            self.tableView.reloadData()
            if self.amiiboList.isEmpty {
                self.tableView.isHidden = true
                self.emptyList.isHidden = false
            } else {
                self.tableView.isHidden = false
                self.emptyList.isHidden = true
            }
        }
    }
}

extension FavoriteAmiibosListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "AmiiboCell", for: indexPath) as! AmiiboCell
        if amiiboList.first != nil{
            cell.amiiboName.text = amiiboList[indexPath.row].name
            cell.amiiboType.text = amiiboList[indexPath.row].type
            cell.amiiboGame.text = amiiboList[indexPath.row].gameSeries
            let url = URL(string: amiiboList[indexPath.row].image ?? "")
            cell.amiiboImage.kf.setImage(with: url)
            cell.buttonLike.isEnabled = false
        } else {
            cell.amiiboName.text = ""
            cell.amiiboType.text = ""
            cell.amiiboGame.text = ""
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            RealmDatabaseRepository.shared().removeAmiibo(id: self.amiiboList[indexPath.row].tail ?? "0")
            self.amiiboList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if self.amiiboList.isEmpty {
                self.tableView.isHidden = true
                self.emptyList.isHidden = false
            } else {
                self.tableView.isHidden = false
                self.emptyList.isHidden = true
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filterClass.findAmiibo( tail: amiiboList[indexPath.row].tail ?? "0", success: { (amiibo) in
            DispatchQueue.main.async {
                self.router.go2DetailView(vc: self, amiibo: amiibo)
            }
        },failure: { (_: Error?) in
            print("Ha ocurrido un error")
        })
    }
}

