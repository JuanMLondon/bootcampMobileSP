//
//  LoginViewModel.swift
//  Reto_Final
//
//  Created by JML on 17/12/22.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @ObservedObject var networkService = NetworkService()
    
    var email: String = ""
    var password: String  = ""
    
    @Published var hasError: Bool = false
    @Published var isLoggingIn: Bool = false
    @Published var isLoggedIn: Bool = false
    
    func login(email: String, password: String) {
        
        if email.isEmpty || password.isEmpty  {
            self.hasError = true
            return
        } else {
            self.isLoggingIn = true
            print("Is Logging In? \(networkService.working) from LoginViewModel")
            networkService.login(email: email, password: password)
            self.isLoggingIn = networkService.working
            self.hasError = networkService.failed
            print("Has error? \(networkService.failed) from LoginViewModel")
            self.isLoggedIn = networkService.success
            print("Is Logged In? \(networkService.success) from LoginViewModel")
            self.isLoggingIn = false
        }
    }
}

struct NavButton1: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @StateObject var authenticated = Authentication()
    @State var isShowingMenuView = false
    
    var body: some View {
        
        NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), isActive: $isShowingMenuView, label: {EmptyView()})
        
        Button("Ingresar") {
            viewModel.login(email: viewModel.email, password: viewModel.password)
            print("Button 1 tapped")
            print("Is Logged In? \($viewModel.isLoggedIn.wrappedValue) from LoginView")
            if authenticated.authenticated == true || viewModel.isLoggedIn == true {
                print("Authenticated? \(authenticated.authenticated)")
                self.isShowingMenuView = true
            }
        }
        .foregroundColor(Color("sophosBC"))
        .environmentObject(authenticated)
        
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intente nuevamente")))
        }
    }
}

struct NavButton2: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @StateObject var authenticated = Authentication()
    @State var isShowingMenuView = false
    
    var body: some View {
        
        NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), isActive: $isShowingMenuView, label: {EmptyView()})
        
        Button("Ingresar con huella") {
            viewModel.login(email: viewModel.email, password: viewModel.password)
            print("Button 2 tapped")
            print("Is Logged In? \($viewModel.isLoggedIn.wrappedValue) from LoginView")
            if authenticated.authenticated == true || viewModel.isLoggedIn == true {
                print("Authenticated? \(authenticated.authenticated)")
                self.isShowingMenuView = true
            }
        }
        .padding(.trailing, 105)
        .environmentObject(authenticated)
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intente nuevamente")))
        }
    }
}
