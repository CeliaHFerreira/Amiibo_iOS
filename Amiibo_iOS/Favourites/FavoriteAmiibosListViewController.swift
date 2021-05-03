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
        
        server.retrieveAmiibos { (amiiboListResponse) in
            if let amibosResponse = amiiboListResponse.amiibo{
                self.amiiboList = amibosResponse
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } failure: { (_: Error?) in
            print("Ha ocurrido un error")
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "AmiiboCell", for: indexPath) as! AmiiboCell
        if let amiibos = amiiboList.first {
            let newName = amiiboList[indexPath.row].name?.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
            cell.amiiboName.text = newName
            cell.amiiboType.text = amiiboList[indexPath.row].type
            cell.amiiboGame.text = amiiboList[indexPath.row].gameSeries
            let url = URL(string: amiiboList[indexPath.row].image ?? "")
            cell.amiiboImage.kf.setImage(with: url)
        } else {
            cell.amiiboName.text = "SuperCosi"
            cell.amiiboType.text = "Hace ejercicio"
            cell.amiiboGame.text = "El juego de los gatos"
            //cell.amiiboImage = UIImageView(image: UIImage(systemName: "leaf.arrow.triangle.circlepath"))
        }
        return cell
    }
//
//    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
        
    }
}

