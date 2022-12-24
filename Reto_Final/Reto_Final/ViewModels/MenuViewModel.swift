//
//  MenuViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class MenuViewModel: ObservableObject {
    
    @ObservedObject var authentication = Authentication()
    @Published var userName: String = ""
    
    func getName() -> String {
        DispatchQueue.main.async {
            self.userName = self.authentication.getLoggedInUser().nombre
        }
        return self.userName
    }
}
