//
//  AmiiboListViewController.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import UIKit
import Foundation
import Kingfisher

class AmiiboListViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
        var amiiboList: [Amiibo] = []
        let server = ApiCalls()

    // Returning the xib file after instantiating it
    override func viewDidLoad() {
        
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.color = .systemPink
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AmiiboCell", bundle: nil), forCellReuseIdentifier: "AmiiboCell")
        
        server.retrieveAmiibos { (amiiboListResponse) in
            if let amibosResponse = amiiboListResponse.amiibo{
                self.amiiboList = amibosResponse
                DispatchQueue.main.async {
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.tableView.reloadData()
                    self.tableView.isHidden = false

                }
            }
        } failure: { (_: Error?) in
            print("Ha ocurrido un error")
        }
    }
    
}

extension AmiiboListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "AmiiboCell", for: indexPath) as! AmiiboCell
        if amiiboList.first != nil {
            let newName = amiiboList[indexPath.row].name?.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
            cell.amiiboName.text = newName
            cell.amiiboType.text = amiiboList[indexPath.row].type
            cell.amiiboGame.text = amiiboList[indexPath.row].gameSeries
            cell.amiibo = amiiboList[indexPath.row]
            let url = URL(string: amiiboList[indexPath.row].image ?? "")
            cell.amiiboImage.kf.setImage(with: url)
        } else {
            cell.amiiboName.text = ""
            cell.amiiboType.text = ""
            cell.amiiboGame.text = ""
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
        
    }
}

