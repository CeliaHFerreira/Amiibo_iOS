//
//  UserDataView.swift
//  Amiibo_iOS
//
//  Created by Celia Herrera Ferreira on 05/05/2021.
//

import SwiftUI

struct UserDataView: View {
    @State var userName: String = ""
    @State var firstName: String = ""
    @State var secondName: String = ""
//
//    @State var currentPassword: String = ""
//    @State var newPassword: String = ""
//    @State var confirmPassword: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Datos de usuario").foregroundColor(Color(UIColor(named: "DarkerGreen")!))) {
                TextField("Nombre", text: $userName)
                TextField("Apellido", text: $firstName)
                TextField("SegundoApellido", text: $secondName)
                
                Button(action: {
                    
                    let defaults = UserDefaults.standard
                    defaults.set(userName, forKey: "Nombre" )
                    defaults.set(firstName, forKey: "Apellido" )
                    defaults.set(secondName, forKey: "SegundoApellido")
                    
                }) {
                    Text("Guardar tus datos").foregroundColor(Color(UIColor(named: "Blue")!))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
            }
            Section(header: Text("Borrar Amiibos favoritos").foregroundColor(Color(UIColor(named: "DarkerGreen")!))) {
                Button(action: {
                    RealmDatabaseRepository.shared().removeAll()
                }) {
                    Text("Resetear favoritos").foregroundColor(Color(UIColor(named: "Pink")!))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
            }
            
        }
        
    }
}


struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserDataView()
            UserDataView()
        }
    }
}
