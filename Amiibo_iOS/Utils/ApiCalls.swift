//
//  ApiCalls.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import Foundation
import FacebookLogin
import FirebaseAuth
import TransitionButton

class ApiCalls {
    
    let router = AmiiboRouting()
    
    func retrieveAmiibos(success: @escaping (_ plantlist: AllAmiibo) -> (), failure: @escaping (_ error: Error?) ->()) {
        let url = URL(string: "https://www.amiiboapi.com/api/amiibo/")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(AllAmiibo.self, from: json)
                success(response)
            } catch let error {
                failure(error)
            }
        }.resume()
    }
    
    func loginCredentials(vc: UIViewController, email: String, password: String, button: TransitionButton) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if result != nil , error == nil {
                UserDefaults.standard.set(true, forKey: "isLogged")
                UserDefaults.standard.synchronize()
                button.cornerRadius = 6
                button.tintColor = .white
                button.backgroundColor = .systemBlue
                button.stopAnimation(animationStyle: .expand, completion: {
                    self.router.go2TabBar(vc: vc)
                })
            } else {
                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                vc.present(alertController, animated:true, completion: nil)
            }
        }
    }
    
    func loginFacebook(vc: UIViewController) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.email], viewController: vc) { (result) in
            switch result {
            case .success(granted: _, declined: _, token: let token):
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                self.customLoginFirebase(vc: vc, credential: credential)
            case .cancelled:
                break
            case .failed(_):
                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                vc.present(alertController, animated:true, completion: nil)
            }
        }
    }
    
    func customLoginFirebase(vc: UIViewController, credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (result, error) in
            if result != nil , error == nil {
                UserDefaults.standard.set(true, forKey: "isLogged")
                UserDefaults.standard.synchronize()
                self.router.go2TabBar(vc: vc)
                
            } else {
                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                vc.present(alertController, animated:true, completion: nil)
            }
        }
    }
    
    func registerFirebase(vc: UIViewController, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if result != nil , error == nil {
                UserDefaults.standard.set(true, forKey: "isLogged")
                UserDefaults.standard.synchronize()
                self.router.go2TabBar(vc: vc)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                vc.present(alertController, animated:true, completion: nil)
            }
        }
    }
}
