//
//  LoginViewController.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import Foundation
import FirebaseAnalytics
import FirebaseAuth
import GoogleSignIn
import FacebookLogin

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let router = AmiiboRouting()
    let server = ApiCalls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent("LoginView", parameters: ["message" : "Iniciada pantalla de Login"])
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        if UserDefaults.standard.bool(forKey: "isLogged"){
            router.go2TabBar(vc: self)
        }
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
            server.loginCredentials(vc: self, email: email, password: password)
        }
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        Analytics.logEvent("GORegister", parameters: ["message" : "Iniciada pantalla de Registro"])
    }
    
    @IBAction func loginGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func loginFacebook(_ sender: Any) {
        server.loginFacebook(vc: self)
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil {
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            server.customLoginFirebase(vc: self, credential: credential)
        }
    }
}
