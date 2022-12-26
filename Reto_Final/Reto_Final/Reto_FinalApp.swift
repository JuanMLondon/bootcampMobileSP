//
//  Reto_FinalApp.swift
//  Reto_Final
//
//  Created by JML on 14/12/22.
//

import SwiftUI

@main
struct Reto_FinalApp: App {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var networkService = NetworkService.shared.self
    
    var body: some Scene {
        
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
                .environmentObject(networkService)
            
            /*if !NetworkService.shared.success {
                LoginView(viewModel: LoginViewModel())
                    .environmentObject(networkService)
            } else {
                MenuView(viewModel: MenuViewModel())
                    .environmentObject(networkService)
            }
             */
        }
    }
}
