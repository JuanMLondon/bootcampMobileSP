//
//  Reto_FinalApp.swift
//  Reto_Final
//
//  Created by JML on 14/12/22.
//

import SwiftUI

@main
struct Reto_FinalApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
    }
}
