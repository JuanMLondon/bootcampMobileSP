//
//  CustomMenuBar.swift
//  Reto_Final
//
//  Created by JML on 29/12/22.
//

import SwiftUI

struct CustomMenuBar: View {
    
    @State var isNavEnabled = false
    @State var goToView: AnyView?
    @State var previousView: String?
    
    var currentView: String = MenuViewModel.sharedMenuViewVM.currentViewSelection ?? ""
    
    var viewTitle: String? {
        let title: String
        switch currentView {
        case "Login":
            title = "Inicio"
        case "Menu":
            title = "Opciones"
        case "SendDocuments":
            title = "Envío de documentación"
        case "ViewDocuments":
            title = "Documentos"
        case "Offices":
            title = "Oficinas"
        default:
            title = ""
        }
        return title
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Button {
                    self.isNavEnabled = true
                    print("Back button was tapped")
                    print("Estado success NetworkService.shared: \(NetworkService.shared.success)")
                    print("Estado isLoggedIn LoginViewModel.sharedLoginViewVM: \(LoginViewModel.sharedLoginViewVM.isLoggedIn)")
                    print("Estado previousView: \(String(describing: previousView))")
                    print("Estado currentViewSelection: \(String(describing: MenuViewModel.sharedMenuViewVM.currentViewSelection))")

                } label:{
                    HStack{
                        Image(systemName: "arrow.left")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 30, height: 20)
                            .foregroundColor(Color("violet_UI"))
                        Text("Regresar")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("violet_UI"))
                            .multilineTextAlignment(.leading)
                    }
                }
                .background(content: {
                    NavigationLink(destination:AnyView(MenuView(viewModel: MenuViewModel())) .navigationBarBackButtonHidden(true), isActive: $isNavEnabled, label: { EmptyView() })
                })
                
                Spacer()
                
                Button {
                    print("Menu button was tapped")
                } label: {
                    
                    DropdownNavigationMenu()
                    
                }
            }
            
            HStack{
                Text(viewTitle ?? "")
                //navigationBarTitle("Menú", displayMode: .inline)
                    .foregroundColor(Color("violet_UI"))
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.all, 0)
    }
}

struct CustomMenuBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomMenuBar()
    }
}
