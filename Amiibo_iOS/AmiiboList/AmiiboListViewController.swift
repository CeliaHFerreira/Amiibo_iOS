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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var amiiboList: [Amiibo] = []
    let server = ApiCalls()
    var searchedAmiibo: [Amiibo] = []
    var searching = false
    
    
    // Returning the xib file after instantiating it
    override func viewDidLoad() {
        
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.color = .systemPink
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AmiiboCell", bundle: nil), forCellReuseIdentifier: "AmiiboCell")
        self.searchBar.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
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
        if searching {
            return searchedAmiibo.count
        } else {
            return amiiboList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "AmiiboCell", for: indexPath) as! AmiiboCell
        if amiiboList.first != nil {
            if !searching {
                let newName = amiiboList[indexPath.row].name?.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
                cell.amiiboName.text = newName
                cell.amiiboType.text = amiiboList[indexPath.row].type
                cell.amiiboGame.text = amiiboList[indexPath.row].gameSeries
                cell.amiibo = amiiboList[indexPath.row]
                
                let url = URL(string: amiiboList[indexPath.row].image ?? "")
                
                if RealmDatabaseRepository.shared().isAmiiboFav(id: amiiboList[indexPath.row].tail ?? "0") {
                    cell.buttonLike.setImage( UIImage(systemName: "star.fill"), for: .normal)
                } else {
                    cell.buttonLike.setImage( UIImage(systemName: "star"), for: .normal)
                }
                cell.amiiboImage.kf.setImage(with: url)
            } else {
                
                let newName = searchedAmiibo[indexPath.row].name?.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
                cell.amiiboName.text = newName
                cell.amiiboType.text = searchedAmiibo[indexPath.row].type
                cell.amiiboGame.text = searchedAmiibo[indexPath.row].gameSeries
                cell.amiibo = searchedAmiibo[indexPath.row]
                let url = URL(string: searchedAmiibo[indexPath.row].image ?? "")
                if RealmDatabaseRepository.shared().isAmiiboFav(id: searchedAmiibo[indexPath.row].tail ?? "0") {
                    cell.buttonLike.setImage( UIImage(systemName: "star.fill"), for: .normal)
                } else {
                    cell.buttonLike.setImage( UIImage(systemName: "star"), for: .normal)
                }
                cell.amiiboImage.kf.setImage(with: url)
            }
            
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

extension AmiiboListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedAmiibo = amiiboList.filter { $0.name!.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

