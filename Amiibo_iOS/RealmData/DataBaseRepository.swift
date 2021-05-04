//
//  DatabaseRepository.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 04/05/2021.
//

import Foundation
import RealmSwift

public protocol DatabaseRepository {
    
    func saveAmiibo(_ object: Object)
    func getAmiibos() -> [Amiibo]
    func removeAll()
    func isAmiiboFav(id: String) -> Bool
    func removeAmiibo(id: String)
    
}
