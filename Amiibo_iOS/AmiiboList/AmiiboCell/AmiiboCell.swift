//
//  AmiiboCell.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import UIKit
import SkeletonView

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
        // Initialization code
        setupSkeleton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func pressLike(_ sender: Any) {
        if !isLiked {
            let amiiboSaved = AmiiboRealm()
            if let amiiboUnw = amiibo {
                if !RealmDatabaseRepository.shared().isAmiiboFav(id: amiiboUnw.tail ?? "0"){
                    amiiboSaved.name = amiiboUnw.name
                    amiiboSaved.type = amiiboUnw.type
                    amiiboSaved.gameSeries = amiiboUnw.gameSeries
                    amiiboSaved.image = amiiboUnw.image
                    amiiboSaved.amiiboId = amiiboUnw.tail
                    RealmDatabaseRepository.shared().saveAmiibo(amiiboSaved)
                }
            }
            buttonLike.setImage( UIImage(systemName: "star.fill"), for: .normal)
            
        } else {
            if let amiiboUnw = amiibo {
                RealmDatabaseRepository.shared().removeAmiibo(id: amiiboUnw.tail ?? "0")
            }
            buttonLike.setImage( UIImage(systemName: "star"), for: .normal)
        }
        isLiked = !isLiked
    }
    
    public func setupSkeleton() {
        
        isSkeletonable = true
        amiiboName.isSkeletonable = true
        amiiboName.linesCornerRadius = 8
        amiiboType.isSkeletonable = true
        amiiboType.linesCornerRadius = 8
        amiiboGame.isSkeletonable = true
        amiiboGame.linesCornerRadius = 8
        amiiboImage.isSkeletonable = true
    }
    
}
