//
//  ContentView.swift
//  Reto_Final
//
//  Created by JML on 14/12/22.
//

import SwiftUI

 struct LoginView: View {
     
     @ObservedObject var viewModel: LoginViewModel
     
     var body: some View {
         NavigationView {
             ZStack {
                 Color("sophosBC")
                 
                 VStack{
                     VStack {
                         Image("sophos_logo")
                             .resizable(resizingMode: .stretch)
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 240.0, height: 80.0)
                             
                         Text("Ingresa tus datos aquí")
                             .foregroundColor(Color("violet_UI"))

                         Spacer()
                             .frame(height: 5)
                         
                         TextFieldRoundedFrame(viewModel: viewModel)
                         SecTextFieldRoundedFrame(viewModel: viewModel)
                     }
                     //.navigationBarTitle("Vista Inicial", displayMode: .inline)
                     .padding(.horizontal, 55)
                     .disabled(viewModel.isLoggingIn)
                     
                     Spacer()
                         .frame(maxHeight: 15)
                     
                     VStack {
                         if viewModel.isLoggingIn {
                             ProgressView()
                                 .progressViewStyle(.circular)
                         } else {
                             NavigationButton1(viewModel: viewModel)
                             NavigationButton2(viewModel: viewModel)
                         }
                     }
                     .padding(.horizontal, 55)
                     .disabled(viewModel.isLoggingIn)
                 }
             }
             .edgesIgnoringSafeArea(.all)
         }
     }
 }


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}


struct TextFieldRoundedFrame: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("sophosBC"))
            .frame(height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(Color("violet_UI"))
                    .padding(.leading, 15)
                
                Divider()
                    .frame(width: 10)
                
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .foregroundColor(Color("violet_UI"))
                    .padding(.horizontal, 5)
                    
            })
            .padding(.vertical, 3)
    }
}

struct SecTextFieldRoundedFrame: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @State var isSecured: Bool = true
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("sophosBC"))
            .frame(height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                Image(systemName: "lock.circle")
                    .foregroundColor(Color("violet_UI"))
                    .padding(.leading, 15)
                
                Divider()
                    .frame(width: 10)
                
                SecureField("Clave", text: $viewModel.password)
                    .disableAutocorrection(true)
                    .foregroundColor(Color("violet_UI"))
                    .padding(.horizontal, 5)
                
                Button(action: {
                     isSecured.toggle()
                 }) {
                     Image(systemName: self.isSecured ? "eye.slash" : "eye")
                         .foregroundColor(Color("violet_UI"))
                         .padding(.trailing, 15)
                 }
            })
            .padding(.vertical, 3)
    }
}

struct NavigationButton1: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @State var selection: String? = nil
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), tag: "MenuView", selection: $selection, label: {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("violet_UI"))
                .frame(width: 350, height: 45.0)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
                .overlay(HStack {
                    Button("Ingresar") {
                        viewModel.login()
                        print(viewModel.loginSuccessful)
                        if viewModel.loginSuccessful == true {
                            self.selection = "MenuView()"
                        }
                    }
                    .foregroundColor(Color("sophosBC"))
                })
                .padding(.vertical, 3)
                .alert(isPresented: $viewModel.hasError) {
                    Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intentar nuevamente")))
                }
        })
    }
}

struct NavigationButton2: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @State var selection: String? = nil
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), tag: "MenuView", selection: $selection, label: {
            RoundedRectangle(cornerRadius: 15)
            
                .fill(Color("sophosBC"))
                .frame(width: 350, height: 45.0)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
                .overlay(HStack {
                    Image(systemName: "touchid")
                        .foregroundColor(Color("violet_UI"))
                        .padding(.leading, 15)
                    Spacer()
                    
                    Button("Ingresar con huella") {
                        viewModel.login()
                        print(viewModel.loginSuccessful)
                        if viewModel.loginSuccessful == true {
                            self.selection = "MenuView()"
                        }
                    }
                    .foregroundColor(Color("violet_UI"))
                    .padding(.trailing, 105)
                    .alert(isPresented: $viewModel.hasError) {
                        Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intentar nuevamente")))
                    }
                })
                .padding(.vertical, 3)
        })
    }
}
