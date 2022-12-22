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
                print("Is Logging In? \(self.isLoggingIn) from LoginViewModel")
                self.networkService.login(email: email, password: password)
            }
    }
    
    func updateStatus() {
        self.hasError = self.networkService.failed
        print("Has error? \(self.networkService.failed) from LoginViewModel")
        self.isLoggedIn = self.networkService.success
        print("Is Logged In? \(self.networkService.success) from LoginViewModel")
        self.isLoggingIn = false
    }
    
    func shouldUpdateView(viewModel: LoginViewModel, isLoggedIn: Bool) -> Bool{
        var showNextView: Bool = false
            if viewModel.isLoggedIn == true {
                showNextView = true
                print("Is LoggedIn? (from NavButtonAction): \(isLoggedIn)")
                print("Should show MenuView? (from NavButtonAction): \(showNextView)")
                return showNextView
            }
        return false
    }
}

struct NavButton1: View {
    
    @ObservedObject var viewModel = LoginViewModel()

    @StateObject var authenticated = Authentication()

    @State var isShowingMenuView = false
    
    var body: some View {
        
        NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), isActive: $isShowingMenuView, label: {EmptyView()})
        
        Button("Ingresar") {
            print("Button 1 tapped")
            viewModel.login(email: viewModel.email, password: viewModel.password)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: viewModel.updateStatus)
            
            var update: Bool = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                update = viewModel.shouldUpdateView(viewModel: viewModel, isLoggedIn: viewModel.isLoggedIn)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                print("Should show MenuView? \(update)")
                self.isShowingMenuView = update // No ejecuta luego de implementar los dispatch queue!!
            }
            
            /*
            print("Button 1 tapped")
            viewModel.login(email: viewModel.email, password: viewModel.password)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: viewModel.updateStatus)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                if authenticated.authenticated == true || viewModel.isLoggedIn == true {
                    self.isShowingMenuView = true // No ejecuta luego de implementar los dispatch queue.
                    print("Is LoggedIn? (from NavButton1): \(viewModel.isLoggedIn)")
                    print("Should show MenuView? \(self.isShowingMenuView)")
                }
            }
             */
             
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
            print("Button 2 tapped")
            viewModel.login(email: viewModel.email, password: viewModel.password)
            
            //DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: viewModel.updateStatus)
            
            viewModel.updateStatus()
            
            //DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                if authenticated.authenticated == true || viewModel.isLoggedIn == true {
                    self.isShowingMenuView = true // No ejecuta luego de implementar los dispatch queue.
                    print("Is LoggedIn? (from NavButton1): \(viewModel.isLoggedIn)")
                    print("Should show MenuView? \(self.isShowingMenuView)")
                }
            //}
        }
        .padding(.trailing, 105)
        .environmentObject(authenticated)
        
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intente nuevamente")))
        }
    }
}


