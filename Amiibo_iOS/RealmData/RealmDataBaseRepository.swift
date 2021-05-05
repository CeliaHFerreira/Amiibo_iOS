//
//  RealmDataBaseRepository.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 04/05/2021.
//

import Foundation
import RealmSwift

public final class RealmDatabaseRepository: DatabaseRepository {
    
    // MARK: - Singleton
    
    private static var repositoryInstance = RealmDatabaseRepository()
    
    public static func shared() -> DatabaseRepository {
        return RealmDatabaseRepository.repositoryInstance
    }
    
    // MARK: - RealmRepository functions
    
    public func saveAmiibo(_ object: Object) {
        do {
            let realm = try Realm()
            try! realm.write ({
                realm.add(object)
            })
        } catch {
            print("Error")
        }
    }
    
    public func removeAll() {
        do {
            let realm = try Realm()
            try! realm.write ({
                realm.deleteAll()
            })
        } catch {
            print("Error")
        }
    }
    
    public func getAmiibos() -> [Amiibo] {
        do {
            let realm = try Realm()
            let amiibos: [Amiibo] = realm.objects(AmiiboRealm.self).map({ $0.parseToDomain() })
            return amiibos
        } catch {
            print("Error")
            return []
        }
    }
    
    public func isAmiiboFav(id: String) -> Bool {
        let amiibos = getAmiibos()
        let isFav = amiibos.filter({ $0.tail == id })
        if isFav.first != nil {
            return true
        } else { return false }
    }
    
    public func removeAmiibo(id: String) {
        do {
            let realm = try Realm()
            if let favorites = realm.objects(AmiiboRealm.self).filter( { $0.amiiboId == id }).first {
                try! realm.write {
                    realm.delete(favorites)
                }
            }
            
        } catch {
            print("Error")
            return
        }
    }
    
    public func getAmiibo(id:String) -> Amiibo? {
        let amiibos = getAmiibos()
        guard let amiibo = amiibos.filter( { $0.tail == id }).first else { return nil }
        return amiibo
    }
    
    
    
}
