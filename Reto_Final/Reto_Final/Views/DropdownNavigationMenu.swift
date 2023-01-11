//
//  DropdownNavigationMenu.swift
//  Reto_Final
//
//  Created by JML on 27/12/22.
//

import SwiftUI


struct DropdownNavigationMenu: View {
    
    @ObservedObject var viewModel = MenuViewModel.shared.self
    @State private var selectedOption: String?
    @State var viewSelection: String?
    @State var isNavEnabled = false
    @State var goToView: AnyView?
    //@State private var shouldShowDropdown = true //Needed for customized Dropdown Menu
    
    var menuItems: [String] = ["Menú principal", "Enviar documentos", "Ver documentos", "Oficinas", "Cerrar sesión"]
    var onOptionSelected: ((_ option: String) -> Void)?
    private let menuButtonHeight: CGFloat = 45
    
    func navigateAction(linkedView: String, navigateTo: AnyView) {
        self.isNavEnabled.toggle()
        let view = linkedView
        self.viewSelection = view
        self.goToView = navigateTo
        self.viewModel.currentViewSelection = viewSelection!
        //print("Go to view: \(String(describing: viewModel.currentViewSelection))")
    }
    
    var body: some View {
            // Standard Dropdown Menu
            Menu(content: {
                
                Dropdown(options: self.menuItems) { option in
                    //shouldShowDropdown = false //Needed for customized Dropdown Menu
                    self.selectedOption = option
                    self.onOptionSelected?(option)
                    
                    switch selectedOption! {
                        
                    case "Menú principal":
                        navigateAction(linkedView: "MenuView", navigateTo: AnyView(MenuView(viewModel: MenuViewModel())))
                        
                    case "Enviar documentos":
                        navigateAction(linkedView: "SendDocuments", navigateTo: AnyView(SendDocumentsView(viewModel: SendDocumentsViewModel())))
                        
                    case "Ver documentos":
                        navigateAction(linkedView: "ViewDocuments", navigateTo: AnyView(ViewDocumentsView(viewModel: ViewDocumentsViewModel())))

                    case "Oficinas":
                        navigateAction(linkedView: "Offices", navigateTo: AnyView(OfficesView(viewModel: OfficesViewModel())))
                        
                    case "Cerrar sesión":
                        navigateAction(linkedView: "LoginView", navigateTo: AnyView(LoginView(viewModel: LoginViewModel())))
                        
                    default:
                        navigateAction(linkedView: "MenuView", navigateTo: AnyView(MenuView(viewModel: MenuViewModel())))
                    }
                    
                }
            }, label:{
                Button {
                    print("Menu button was tapped")
                } label: {
                    Image("menu_icon")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40.0, height: 36.0)
                }
                .overlay(content: {
                    NavigationLink(destination: goToView.navigationBarBackButtonHidden(true), isActive: $isNavEnabled, label: { EmptyView() })
                })
            })
    }
}

struct DropdownNavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropdownNavigationMenu()
    }
}
