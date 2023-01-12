//
//  Reto_FinalApp.swift
//  Reto_Final
//
//  Created by JML on 14/12/22.
//

import SwiftUI

@main
struct Reto_FinalApp: App {

    @StateObject var authenticationService = AuthenticationService.shared.self
    
    var body: some Scene {
        
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
                .environmentObject(authenticationService)

        }
    }
}
