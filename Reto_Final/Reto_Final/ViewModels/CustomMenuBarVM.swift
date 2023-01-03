//
//  CustomMenuBarVM.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import SwiftUI

class CustomMenuBarVM: ObservableObject {
    
    static let sharedCustomMenuBarVM = CustomMenuBarVM()
    
    @Published var isNavEnabled = false
    @Published var goToView: AnyView?
    @Published var previousView: String?
    @Published var currentView: String = MenuViewModel.sharedMenuViewVM.currentViewSelection ?? ""
    var viewTitle: String?
    
    func backButtonAction() -> Bool{
        self.isNavEnabled = true
        print("Back button was tapped")
        print("Estado success NetworkService.shared: \(NetworkService.shared.success)")
        print("Estado isLoggedIn LoginViewModel.sharedLoginViewVM: \(LoginViewModel.sharedLoginViewVM.isLoggedIn)")
        print("Estado previousView: \(String(describing: previousView))")
        print("Estado currentViewSelection: \(String(describing: MenuViewModel.sharedMenuViewVM.currentViewSelection))")
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
