//
//  HostingUserData.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 05/05/2021.
//

import UIKit
import SwiftUI

class HostingUserData: UIViewController {
    
    let router = AmiiboRouting()
    
    let defaults = UserDefaults.standard
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = defaults.string(forKey: "Nombre")
        let firstName = defaults.string(forKey: "Apellido")
        let secondName = defaults.string(forKey: "SegundoApellido")
        let contentView = UIHostingController(rootView: UserDataView(userName: name ?? "", firstName: firstName ?? "", secondName: secondName ?? ""))
        
        addChild(contentView)
        view.addSubview(contentView.view)
        
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            contentView.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: contentView.view.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        contentView.didMove(toParent: self)

    }
   
    @IBAction func logout(_ sender: Any) {
        router.go2Login(vc: self)
        UserDefaults.standard.set(false, forKey: "isLogged")
    }
    
}

