//
//  AmiiboRealm.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 04/05/2021.
//

import Foundation
import RealmSwift

class AmiiboRealm: Object{
    
    @objc dynamic var name: String? = ""
    @objc dynamic var type: String? = ""
    @objc dynamic var gameSeries: String? = ""
    @objc dynamic var image: String? = ""
    @objc dynamic var amiiboId: String? = ""
    
    static func create(name: String,
                       type:String,
                       gameSeries:String,
                       image:String, ammiboId: String) -> AmiiboRealm {
        let amiibo = AmiiboRealm()
        amiibo.name = name
        amiibo.type = type
        amiibo.gameSeries = gameSeries
        amiibo.image = image
        amiibo.amiiboId = ammiboId
        return amiibo
    }
}

extension AmiiboRealm {
    func parseToDomain() -> Amiibo {
        Amiibo(gameSeries: self.gameSeries, image: self.image, name: self.name, tail: self.amiiboId, type: self.type)
    }
}
