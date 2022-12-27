//
//  MenuViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class MenuViewModel: ObservableObject {
    
    @ObservedObject var networkService = NetworkService.shared.self
    @Published var currentViewSelection: String = "MenuView"
    //@Published var currentView = currentViewSelection
    
    func getLoggedUser() -> UserModel{
        return networkService.getLoggedInUser()
    }
}
