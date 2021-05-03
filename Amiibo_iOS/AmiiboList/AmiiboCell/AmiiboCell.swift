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
    
    @IBOutlet weak var buttonLike: UIButton!
    
    var isLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonLike.setImage( UIImage(systemName: "star"), for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressLike(_ sender: Any) {
        if isLiked {
        buttonLike.setImage( UIImage(systemName: "star.fill"), for: .normal)
        } else {
        buttonLike.setImage( UIImage(systemName: "star"), for: .normal)
        }
        isLiked = !isLiked
    }
    
}
