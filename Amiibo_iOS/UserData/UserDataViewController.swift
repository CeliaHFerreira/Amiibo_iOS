//
//  UserDataViewController.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import UIKit
import Foundation

class UserDataViewController: UIViewController {
    
    let router = AmiiboRouting()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Analytucs Event
    }
    
    
    @IBAction func pressLogOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isNotLogged")
        UserDefaults.standard.synchronize()

        router.go2Login(vc: self)
    }
    
    @IBAction func deleteAmiiboData(_ sender: Any) {
        RealmDatabaseRepository.shared().removeAll()

    }
    
}
