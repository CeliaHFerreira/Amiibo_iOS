//
//  AmiiboRouting.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import Foundation
import UIKit
import SwiftUI

class AmiiboRouting {
    

    func go2Login(initial:UIViewController){
        let vc = initial.storyboard?.instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
        self.switchRootViewController(rootViewController: vc, animated: true, completion: nil)
    }

    func go2TabBar(initial: UIViewController)-> (){


            let vc = initial.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            vc.selectedViewController = vc.viewControllers?[0]

            self.switchRootViewController(rootViewController: vc, animated: true, completion: nil)

    }

    func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let window = UIApplication.shared.keyWindow else { return }
        if animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = rootViewController
                UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                if (completion != nil) {
                    completion!()
                }
            })
        } else {
            window.rootViewController = rootViewController
        }
    }
    
}