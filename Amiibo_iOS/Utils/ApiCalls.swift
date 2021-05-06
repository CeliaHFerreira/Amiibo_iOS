//
//  ApiCalls.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 03/05/2021.
//

import Foundation

class ApiCalls {
    
    func retrieveAmiibos(success: @escaping (_ plantlist: AllAmiibo) -> (), failure: @escaping (_ error: Error?) ->())  {
        let url = URL(string: "https://www.amiiboapi.com/api/amiibo/")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
              do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(AllAmiibo.self, from: json)
                success(response)
            } catch let error {
                failure(error)
            }
        }.resume()

    }
    
}
