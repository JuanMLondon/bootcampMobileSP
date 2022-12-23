//
//  Authentication.swift
//  Reto_Final
//
//  Created by JML on 20/12/22.
//

import SwiftUI

class Authentication: ObservableObject {
    
    @ObservedObject var networkService = NetworkService()
    
    @Published var authenticated: Bool = false
    @Published var userName: String = ""
    
    func updateState() {
        self.authenticated = networkService.success // No funciona
        print("Athenticated updated?: \(self.authenticated)")
        self.userName = networkService.user?.nombre ?? "Juan" // No funciona
        print("Nombre: \(self.userName)")
    }
}
