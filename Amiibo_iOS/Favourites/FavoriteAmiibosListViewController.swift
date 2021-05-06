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
    
    @IBOutlet weak var tableView: UITableView!
    var amiiboList: [Amiibo] = []
    let server = ApiCalls()
    
    
    // Returning the xib file after instantiating it
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AmiiboCell", bundle: nil), forCellReuseIdentifier: "AmiiboCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.amiiboList = RealmDatabaseRepository.shared().getAmiibos()
            self.tableView.reloadData()
            
            if self.amiiboList.isEmpty {
                self.tableView.isHidden = true
            } else {
                self.tableView.isHidden = false
            }
        }
    }
    
    //    func retrievePlantsList() {
    //        guard let url = URL(string: "https:\\") else { return } //Falta meter url plantas
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //
    //            guard let json = data else { return }
    //            //Serializamos los datos
    //            do {
    //                let decoder = JSONDecoder()
    //                //self.dataArray = try decoder.decode([Plant].self, from: json)
    //            } catch let error {
    //                print("Ha ocurrido un error: \(error.localizedDescription)")
    //            }
    //        }.resume()
    //    }
    //
    //
    //    func navDetail(plantID: Int){
    //        let vc = DetailPlantViewController()
    //        let nc = UINavigationController(rootViewController: vc)
    //        present(nc, animated: true, completion: nil)
    //    }
    
}

extension FavoriteAmiibosListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "AmiiboCell", for: indexPath) as! AmiiboCell
        if let amiibos = amiiboList.first {
            cell.amiiboName.text = amiiboList[indexPath.row].name
            cell.amiiboType.text = amiiboList[indexPath.row].type
            cell.amiiboGame.text = amiiboList[indexPath.row].gameSeries
            let url = URL(string: amiiboList[indexPath.row].image ?? "")
            cell.amiiboImage.kf.setImage(with: url)
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
            } else {
                self.tableView.isHidden = false
            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
        
    }
}

