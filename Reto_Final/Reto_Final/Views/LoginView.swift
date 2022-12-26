//
//  ContentView.swift
//  Reto_Final
//
//  Created by JML on 14/12/22.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = LoginViewModel()
    @State var isShowingMenuView = false
    
    func navButton(_ buttonLabel: String) -> Button<Text> {
        return Button(buttonLabel) {
            
            self.viewModel.login(email: viewModel.email, password: viewModel.password)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.viewModel.updateBusyStatus()
                self.isShowingMenuView = self.viewModel.isLoggedIn
                self.viewModel.saveUserSettings()
                
                let usedEmail = viewModel.defaults?.string(forKey: "LastUserEmail")
                print("\(usedEmail!) was saved.")
            }
        }
    }
    
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
                    //.onTapGesture {
                        //UIApplication.shared.inputView?.endEditing(true)
                    //}
                    //.navigationBarTitle("Vista Inicial", displayMode: .inline)
                    .padding(.horizontal, 55)
                    .environmentObject(viewModel)
                    .disabled(viewModel.isLoggingIn)
                    
                    Spacer()
                        .frame(maxHeight: 15)
                    
                    VStack {
                        if viewModel.isLoggingIn {
                            ProgressView()
                                .progressViewStyle(.circular)
                        } else {
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("violet_UI"))
                                .frame(width: 350, height: 45.0)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
                                .overlay(HStack {
                                    
                                    NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), isActive: $isShowingMenuView, label: {
                                        
                                        navButton("Ingresar")
                                            .foregroundColor(Color("sophosBC"))
                                            .foregroundColor(Color("sophosBC"))
                                            .environmentObject(viewModel)
                                            .alert(isPresented: $viewModel.hasError) {
                                                Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intente nuevamente")))
                                            }
                                    })
                                    .disabled(viewModel.isLoggedIn)
                                })
                                .padding(.vertical, 3)
                            
                            RoundedRectangle(cornerRadius: 15)
                            
                                .fill(Color("sophosBC"))
                                .frame(width: 350, height: 45.0)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
                                .overlay(HStack {
                                    
                                    Image(systemName: "touchid")
                                        .foregroundColor(Color("violet_UI"))
                                        .padding(.leading, 15)
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(true), isActive: $isShowingMenuView, label: {
                                        
                                        navButton("Ingresar con huella")
                                            .padding(.trailing, 105)
                                            .foregroundColor(Color("violet_UI"))
                                            .environmentObject(viewModel)
                                        
                                            .alert(isPresented: $viewModel.hasError) {
                                                Alert(title: Text("Datos no validos"), message: Text("El usuario o la contraseña son incorrectos."), dismissButton: .default(Text("Intente nuevamente")))
                                            }
                                    })
                                    .disabled(viewModel.isLoggedIn)
                                })
                                .padding(.vertical, 3)
                        }
                    }
                    .padding(.horizontal, 55)
                    .disabled(viewModel.isLoggingIn)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear(perform: {
            let usedEmail = viewModel.defaults?.string(forKey: "LastUserEmail")
            print("Last used email: \(usedEmail ?? "Not found.")")
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}


struct TextFieldRoundedFrame: View {
    
    @StateObject var viewModel = LoginViewModel()
    
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
                    .environmentObject(viewModel)
            })
            .padding(.vertical, 3)
    }
}

struct SecTextFieldRoundedFrame: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State var isPasswordSecured: Bool = true
    @FocusState var inFocus: Field?
    
    enum Field {
        case secure, plain
    }
    
    var body: some View {
        
        if isPasswordSecured {
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
                        .focused($inFocus, equals: .secure)
                    
                    Button(action: { isPasswordSecured.toggle() },label: {
                        Image(systemName: self.isPasswordSecured ? "eye.slash" : "eye")
                            .foregroundColor(Color("violet_UI"))
                            .padding(.trailing, 15)
                    })
                })
                .padding(.vertical, 3)
        } else {
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
                    
                    TextField("Clave", text: $viewModel.password)
                        .disableAutocorrection(true)
                        .foregroundColor(Color("violet_UI"))
                        .padding(.horizontal, 5)
                        .focused($inFocus, equals: .plain)
                    
                    Button(action: { isPasswordSecured.toggle() },label: {
                        Image(systemName: self.isPasswordSecured ? "eye.slash" : "eye")
                            .foregroundColor(Color("violet_UI"))
                            .padding(.trailing, 15)
                    })
                })
                .padding(.vertical, 3)
        }
    }
}
