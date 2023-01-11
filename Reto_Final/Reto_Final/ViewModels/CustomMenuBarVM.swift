//
//  CustomMenuBarVM.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import SwiftUI

class CustomMenuBarVM: ObservableObject {
    
    // Singleton
    static let shared = CustomMenuBarVM()
    
    @Published var isNavEnabled = false
    @Published var goToView: AnyView?
    @Published var previousView: String?
    @Published var currentView: String = MenuViewModel.shared.currentViewSelection ?? ""
    var viewTitle: String?
    
    func backButtonAction() -> Bool{
        self.isNavEnabled = true
        print("Back button was tapped")
        print("Estado success AuthenticationService.shared: \(AuthenticationService.shared.success)")
        print("Estado isLoggedIn LoginViewModel.sharedLoginViewVM: \(LoginViewModel.shared.isLoggedIn)")
        print("Estado previousView: \(String(describing: previousView))")
        print("Estado currentViewSelection: \(String(describing: MenuViewModel.shared.currentViewSelection))")
        return self.isNavEnabled
    }
    
    func getTitle(currentView: String) -> String {
        switch currentView {
        case "Login":
            self.viewTitle = "Inicio"
        case "Menu":
            self.viewTitle = "Opciones"
        case "SendDocuments":
            self.viewTitle = "Envío de documentación"
        case "ViewDocuments":
            self.viewTitle = "Documentos"
        case "Offices":
            self.viewTitle = "Oficinas"
        default:
            self.viewTitle = ""
        }
        return self.viewTitle!
    }
}
