//
//  Authentication.swift
//  Reto_Final
//
//  Created by JML on 20/12/22.
//

import SwiftUI

class Authentication: ObservableObject {
    
    @Published var authenticated: Bool = false
    @Published var userName: String = ""
    
    func updateState() {
        
    }
}
