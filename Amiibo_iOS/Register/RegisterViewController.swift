//
//  RegisterViewController.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseAnalytics


class RegisterViewController: UIViewController {
    
    let server = ApiCalls()

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let enrolmentRouter = AmiiboRouting()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text {
            server.registerFirebase(vc: self, email: email, password: password)
        }
    }
}



