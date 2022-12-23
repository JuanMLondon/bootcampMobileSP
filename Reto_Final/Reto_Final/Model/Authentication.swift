//
//  Authentication.swift
//  Reto_Final
//
//  Created by JML on 20/12/22.
//

import SwiftUI

class Authentication: ObservableObject {
    
    @Published var user: UserModel = UserModel(id: "", nombre: "", apellido: "", acceso: false, admin: false)
    @Published var authenticated: Bool = false
    
    var networkService = NetworkService()
    
    func isAuthenticated() -> Bool {
        self.authenticated = NetworkService.shared.success
        return authenticated
    }
    
    func getLoggedInUser() -> UserModel {
        DispatchQueue.main.async {
            self.user = NetworkService.shared.loggedInUser ?? UserModel(id: "", nombre: "", apellido: "", acceso: false, admin: false)
        }
        return user
    }
}
