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
    

    func go2Login(vc:UIViewController){
        let vc = vc.storyboard?.instantiateViewController(withIdentifier: "NavigationLogin") as! UINavigationController
        self.switchRootViewController(rootViewController: vc, animated: true, completion: nil)
    }

    func go2TabBar(vc: UIViewController)-> (){

            let vc = vc.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            vc.selectedViewController = vc.viewControllers?[0]
            self.switchRootViewController(rootViewController: vc, animated: true, completion: nil)
    }
    
    func go2DetailView(vc: UIViewController, amiibo: Amiibo) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "AmiiboDetail", bundle: nil)
        let detailView = storyBoard.instantiateViewController(withIdentifier: "AmiiboDetail") as! AmiiboDetailViewController
        detailView.amiibo = amiibo
        vc.navigationController?.pushViewController(detailView, animated: true)
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
