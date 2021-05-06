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
            Section(header: Text("Datos de usuario")) {
                TextField("Nombre", text: $userName)
                TextField("Apellido", text: $firstName)
                TextField("SegundoApellido", text: $secondName)
                
                Button(action: {
                    
                    let defaults = UserDefaults.standard
                    defaults.set(userName, forKey: "Nombre" )
                    defaults.set(firstName, forKey: "Apellido" )
                    defaults.set(secondName, forKey: "SegundoApellido")
                    
                }) {
                    Text("Guardar tus datos")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
            }
            
            //            Section(header: Text("Modificar Contraseña")) {
            //                TextField("Contraseña antigua", text: $currentPassword)
            //                TextField("Contraseña nueva", text: $newPassword)
            //                TextField("Repetir contraseña", text: $confirmPassword)
            //                Button(action: {
            //
            //
            //                }) {
            //                    Text("Guardar tus datos")
            //                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            //                }
            //            }
            
            Section(header: Text("Borrar Amiibos favoritos")) {
                Button(action: {
                    RealmDatabaseRepository.shared().removeAll()
                }) {
                    Text("Resetear favoritos")
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
