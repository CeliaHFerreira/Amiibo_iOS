//
//  LoginViewController.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import Foundation
import FirebaseAnalytics
import FirebaseAuth

class LoginViewController: UIViewController {

  
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let router = AmiiboRouting()
    let server = ApiCalls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //Analytucs Event
        Analytics.logEvent("LoginView", parameters: ["message" : "Iniciada pantalla de Login"])
       //RealmDatabaseRepository.shared().removeAll()

    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
        
    
    @IBAction func loginButton(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text {
            //Checkeamos si son validos por un validator...
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if let result = result, error == nil {
                    //Llamamos al router para mandarnos a la pantalla de listado
                    UserDefaults.standard.set(true, forKey: "isNotLogged")
                    UserDefaults.standard.synchronize()

                    self.router.go2TabBar(initial: self)


                } else {
                    //Gestionamos error
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated:true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        Analytics.logEvent("GORegister", parameters: ["message" : "Iniciada pantalla de Registro"])
    }
    

    
}
