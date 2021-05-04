//
//  AmiiboCell.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import UIKit

class AmiiboCell: UITableViewCell {
    
    @IBOutlet weak var amiiboName: UILabel!
    @IBOutlet weak var amiiboType: UILabel!
    @IBOutlet weak var amiiboGame: UILabel!
    @IBOutlet weak var amiiboImage: UIImageView!
    var amiibo: Amiibo?
    @IBOutlet weak var buttonLike: UIButton!
    
    var isLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if amiibo != nil {
            self.isLiked = RealmDatabaseRepository.shared().isAmiiboFav(id: amiibo?.head ?? "0")
        }
        if isLiked {
            buttonLike.setImage( UIImage(systemName: "star.fill"), for: .normal)
        } else {
            buttonLike.setImage( UIImage(systemName: "star"), for: .normal)
        }
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func pressLike(_ sender: Any) {
        if isLiked {
            let amiiboSaved = AmiiboRealm()
            if let amiiboUnw = amiibo {
                if !RealmDatabaseRepository.shared().isAmiiboFav(id: amiiboUnw.head ?? "0"){
                    amiiboSaved.name = amiiboUnw.name
                    amiiboSaved.type = amiiboUnw.type
                    amiiboSaved.gameSeries = amiiboUnw.gameSeries
                    amiiboSaved.image = amiiboUnw.image
                    //amiiboSaved.id = amiiboUnw.head
                    RealmDatabaseRepository.shared().saveAmiibo(amiiboSaved)
                }
            }
            buttonLike.setImage( UIImage(systemName: "star.fill"), for: .normal)
            
        } else {
            if let amiiboUnw = amiibo {
                RealmDatabaseRepository.shared().removeAmiibo(id: amiiboUnw.head ?? "0")
            }
            buttonLike.setImage( UIImage(systemName: "star"), for: .normal)
        }
        isLiked = !isLiked
    }
    
}
