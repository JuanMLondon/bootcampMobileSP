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
    
    //@State var working: Bool = false
    //@State var failed: Bool = false
    //@State var success: Bool = false
    
    
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

struct NavigationButton1: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @State var selection: String? = nil
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("violet_UI"))
            .frame(width: 350, height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                NavLinkButton(viewModel: viewModel, selection: selection)
            })
            .padding(.vertical, 3)
    }
}

struct NavigationButton2: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @State var selection: String? = nil
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
        
            .fill(Color("sophosBC"))
            .frame(width: 350, height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                Image(systemName: "touchid")
                    .foregroundColor(Color("violet_UI"))
                    .padding(.leading, 15)
                Spacer()
                
                NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), tag: "MenuView", selection: $selection, label: {
                    Button("Ingresar con huella") {
                        viewModel.login(email: viewModel.email, password: viewModel.password)
                        print("Button 2 tapped")
                        print("Is Logged In? \($viewModel.isLoggedIn.wrappedValue)")
                    }
                    .alert(isPresented: $viewModel.hasError) {
                        Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intente nuevamente")))
                    }
                })
                .foregroundColor(Color("violet_UI"))
                .padding(.trailing, 105)
            })
            .padding(.vertical, 3)
    }
}



/* // No implementation of  Observable Pattern between model and view model
import Foundation

class LoginViewModel: ObservableObject {
    
    var email: String = ""
    var password: String  = ""
    
    @Published var hasError: Bool = NetworkService.shared.hasError
    @Published var isLoggingIn: Bool = NetworkService.shared.isLoggingIn
    @Published var isLoggedIn: Bool = NetworkService.shared.isLoggedIn
    
    
    func login(email: String, password: String) {
        
        if email.isEmpty || password.isEmpty  {
            return
        } else {
            //self.isLoggingIn = true
            self.isLoggingIn = NetworkService.shared.isLoggingIn
            print("Is Logging In? \(NetworkService.shared.isLoggingIn) from LoginViewModel")
            NetworkService.shared.login(email: email, password: password)
            self.hasError = NetworkService.shared.hasError
            print("Has error? \(NetworkService.shared.hasError) from LoginViewModel")
            self.isLoggedIn = NetworkService.shared.isLoggedIn
            print("Is Logged In? \(NetworkService.shared.isLoggedIn) from LoginViewModel")
        }
        //self.isLoggingIn = false
    }
}
*/
