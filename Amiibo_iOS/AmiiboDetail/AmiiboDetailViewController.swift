//
//  AmiiboDetailViewController.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 10/05/2021.
//

import Foundation
import Kingfisher

class AmiiboDetailViewController: UIViewController {
    
    var amiibo: Amiibo?
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var imageAmiibo: UIImageView!
    @IBOutlet weak var nameAmiibo: UILabel!
    @IBOutlet weak var typeAmiibo: UILabel!
    @IBOutlet weak var game: UILabel!
    @IBOutlet weak var dateAmerica: UILabel!
    @IBOutlet weak var dateEurope: UILabel!
    @IBOutlet weak var dateJapan: UILabel!
    @IBOutlet weak var dateAustralia: UILabel!
    @IBOutlet weak var vewAmiibo: UIView!
    
    // Returning the xib file after instantiating it
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        nameTitle.text = amiibo?.name ?? ""
        if let imageamiibo = amiibo?.image {
            let url = URL(string: imageamiibo)
            imageAmiibo.kf.setImage(with: url)
        }
        nameAmiibo.text = amiibo?.character ?? ""
        typeAmiibo.text = amiibo?.type ?? ""
        game.text = amiibo?.gameSeries ?? ""
        dateAmerica.text = "EEUU: \(amiibo?.release?.na ?? "") "
        dateEurope.text = "Europa: \(amiibo?.release?.eu ?? "") "
        dateAustralia.text = "Australia: \(amiibo?.release?.au ?? "") "
        dateJapan.text = "Japón: \(amiibo?.release?.jp ?? "") "
        vewAmiibo.layer.cornerRadius = 10
    }
    
}
