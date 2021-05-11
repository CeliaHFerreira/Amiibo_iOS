//
//  AmiiboListViewController.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import UIKit
import Foundation
import Kingfisher
import SkeletonView

class AmiiboListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let router = AmiiboRouting()
    
    var amiiboList: [Amiibo] = []
    let server = ApiCalls()
    var searchedAmiibo: [Amiibo] = []
    var searching = false
    
    
    // Returning the xib file after instantiating it
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Volver")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "DarkerGreen")
        tableView.register(UINib(nibName: "AmiiboCell", bundle: nil), forCellReuseIdentifier: "AmiiboCell")
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        server.retrieveAmiibos { (amiiboListResponse) in
            if let amibosResponse = amiiboListResponse.amiibo{
                DispatchQueue.main.async {
                    self.tableView.isSkeletonable = true
                    self.tableView.reloadData()
                    self.tableView.showAnimatedGradientSkeleton()
                    self.tableView.isHidden = false
                    // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.amiiboList = amibosResponse
                    self.tableView.reloadData()
                    self.tableView.hideSkeleton()
                    //}
                }
            }
        } failure: { (_: Error?) in
            print("Ha ocurrido un error")
        }
    }
    
}

extension AmiiboListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if amiiboList.first != nil {
            if searching {
                return searchedAmiibo.count
            } else {
                return amiiboList.count
            }
        } else {
            return 10
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
            cell.isSkeletonable = true
            cell.amiiboName.isSkeletonable = true
            cell.amiiboName.linesCornerRadius = 8
            cell.amiiboType.isSkeletonable = true
            cell.amiiboType.linesCornerRadius = 8
            cell.amiiboGame.isSkeletonable = true
            cell.amiiboGame.linesCornerRadius = 8
            cell.amiiboImage.isSkeletonable = true
            cell.showSkeleton()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !searching {
            router.go2DetailView(vc: self, amiibo: amiiboList[indexPath.row])
        } else {
            router.go2DetailView(vc: self, amiibo: searchedAmiibo[indexPath.row])
        }
    }
}

extension AmiiboListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedAmiibo = amiiboList.filter { $0.name!.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.gameSeries!.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

