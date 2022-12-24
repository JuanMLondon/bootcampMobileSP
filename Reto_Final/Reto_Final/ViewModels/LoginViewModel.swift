//
//  LoginViewModel.swift
//  Reto_Final
//
//  Created by JML on 17/12/22.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @ObservedObject var authenticated = Authentication()
    
    @Published var hasError: Bool = false
    @Published var isLoggingIn: Bool = false
    @Published var isLoggedIn: Bool = false
    
    var email: String = ""
    var password: String  = ""
    
    func login(email: String, password: String) {
            if email.isEmpty || password.isEmpty  {
                self.hasError = true
                return
            } else {
                self.isLoggingIn = true
                NetworkService.shared.login(email: email, password: password)
            }
    }
    
    func updateStatus() {
        self.hasError = NetworkService.shared.failed
        self.isLoggedIn = NetworkService.shared.success
        self.isLoggingIn = false
    }
    
    func shouldUpdateView(viewModel: LoginViewModel, isLoggedIn: Bool) -> Bool{
        if authenticated.isAuthenticated() == true {
                return true
            }
        return false
    }
    
    func showPasswordToggle() -> Void{
        
    }
}

struct NavButton1: View {
    
    @StateObject var authentication = Authentication()
    @StateObject var viewModel = LoginViewModel()
    @State var isShowingMenuView = false
    @State var update: Bool = false
    
    var body: some View {
        
        NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), isActive: $isShowingMenuView, label: {EmptyView()})
        
        Button("Ingresar") {
            
            viewModel.login(email: viewModel.email, password: viewModel.password)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                
                viewModel.updateStatus()
                
                self.update = authentication.isAuthenticated()
                
                self.isShowingMenuView = update
            }
            
        }
        .foregroundColor(Color("sophosBC"))
        
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intente nuevamente")))
        }
    }
}

struct NavButton2: View {
    
    @StateObject var authentication = Authentication()
    @StateObject var viewModel = LoginViewModel()
    @State var isShowingMenuView = false
    @State var update: Bool = false
    
    var body: some View {
        
        NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), isActive: $isShowingMenuView, label: {EmptyView()})
        
        Button("Ingresar con huella") {
 
            viewModel.login(email: viewModel.email, password: viewModel.password)
            
            viewModel.updateStatus()
            
            update = authentication.isAuthenticated()
            
            self.isShowingMenuView = update

        }
        .padding(.trailing, 105)
        
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intente nuevamente")))
        }
    }
}

