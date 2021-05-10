//
//  FilterAmiibos.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 10/05/2021.
//

import Foundation


class FilterAmiibos {
    
    let server = ApiCalls()
    var amiiboList: [Amiibo] = []
    
    func findAmiibo(tail: String, success: @escaping (_ amiibo: Amiibo) -> (), failure: @escaping (_ error: Error?) ->()) {
        self.server.retrieveAmiibos { (amiiboListResponse) in
            if let amiibosResponse = amiiboListResponse.amiibo {
                    if let result = amiibosResponse.filter({ $0.tail == tail }).first {
                        success(result)
                    }
            }
        } failure: { (_: Error?) in
            print("Ha ocurrido un error")
        }
        
    }
}
