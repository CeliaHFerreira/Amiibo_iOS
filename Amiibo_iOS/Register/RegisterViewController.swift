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
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let enrolmentRouter = AmiiboRouting()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Analytucs Event
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        
        if let email = emailText.text, let password = passwordText.text {
            //Checkeamos si son validos por un validator...
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let result = result, error == nil {
                    UserDefaults.standard.set(true, forKey: "isNotLogged")
                    UserDefaults.standard.synchronize()
                    self.enrolmentRouter.go2TabBar(initial: self)
                    
                    //Llamamos al router para mandarnos a la pantalla de listado
                    print("hola")
                } else {
                    //Gestionamos error
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated:true, completion: nil)
                }
            }
        }
    }
}



