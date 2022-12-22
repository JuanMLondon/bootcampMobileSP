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
    @Published var userName: String = "Juan"
    
    func updateState() {
        self.authenticated = self.networkService.success
    }
}
