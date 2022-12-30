//
//  DropdownNavigationMenu.swift
//  Reto_Final
//
//  Created by JML on 27/12/22.
//

import SwiftUI


struct DropdownNavigationMenu: View {
    
    @ObservedObject var viewModel = MenuViewModel.sharedMenuViewVM.self
    @State private var selectedOption: String?
    @State var viewSelection: String?
    @State var isNavEnabled = false
    @State var goToView: AnyView?
    //@State private var shouldShowDropdown = true //Needed for customized Dropdown Menu
    
    var menuItems: [String] = ["Menú principal", "Enviar documentos", "Ver documentos", "Oficinas", "Cerrar sesión"]
    var onOptionSelected: ((_ option: String) -> Void)?
    private let menuButtonHeight: CGFloat = 45
    
    func navigateAction(linkedView: String, navigateTo: AnyView) {
        self.isNavEnabled = true
        let view = linkedView
        self.viewSelection = view
        self.goToView = navigateTo
        self.viewModel.currentViewSelection = viewSelection!
        print("Go to view: \(String(describing: viewModel.currentViewSelection))")
    }
    
    var body: some View {
            // Default Dropdown Menu
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

struct Dropdown: View {
    var options: [String]
    var onOptionSelected: ((_ option: String) -> Void)?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                }
            }
        }
        .frame(minHeight: CGFloat(options.count) * 30, maxHeight: 250)
        .padding(.vertical, 5)
        .background(Color("sophosBC"))
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("violet_UI"), lineWidth: 1)
        )
    }
}

struct DropdownRow: View {
    
    var option: String
    var onOptionSelected: ((_ option: String) -> Void)?
    
    var body: some View {
        
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }, label: {
            HStack {
                Spacer()
                Text(self.option)
                    .font(.callout)
                    .foregroundColor(Color("violet_UI"))
                    .multilineTextAlignment(.center)
            }
        })
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}

struct DropdownNavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropdownNavigationMenu()
    }
}

/*// MVVM
 struct DropdownNavigationMenu: View {
     
     @StateObject var viewModel = MenuViewModel.sharedMenuViewVM.self
     @StateObject var mainViewModel = DropdownNavigationMenuVM.sharedDropdownNMVM.self
     @State private var selectedOption: String?
     //@State var viewSelection: String?
     //@State var isNavEnabled = false
     //@State var goToView: AnyView?
     //@State private var shouldShowDropdown = true //Needed for customized Dropdown Menu
     
     var menuItems: [String] = ["Menú principal", "Enviar documentos", "Ver documentos", "Oficinas", "Cerrar sesión"]
     var onOptionSelected: ((_ option: String) -> Void)?
     private let menuButtonHeight: CGFloat = 45
     
     var body: some View {
             // Default Dropdown Menu
             Menu(content: {
                 
                 Dropdown(options: self.menuItems) { option in
                     //shouldShowDropdown = false //Needed for customized Dropdown Menu
                     self.selectedOption = option
                     self.onOptionSelected?(option)
                     
                     switch selectedOption! {
                         
                     case "Menú principal":
                         mainViewModel.navigateAction(linkedView: "MenuView", navigateTo: AnyView(MenuView(viewModel: MenuViewModel())))
                         
                     case "Enviar documentos":
                         mainViewModel.navigateAction(linkedView: "SendDocuments", navigateTo: AnyView(SendDocumentsView(viewModel: SendDocumentsViewModel())))
                         
                     case "Ver documentos":
                         mainViewModel.navigateAction(linkedView: "ViewDocuments", navigateTo: AnyView(ViewDocumentsView(viewModel: ViewDocumentsViewModel())))

                     case "Oficinas":
                         mainViewModel.navigateAction(linkedView: "Offices", navigateTo: AnyView(OfficesView(viewModel: OfficesViewModel())))
                         
                     case "Cerrar sesión":
                         mainViewModel.navigateAction(linkedView: "LoginView", navigateTo: AnyView(LoginView(viewModel: LoginViewModel())))
                         
                     default:
                         mainViewModel.navigateAction(linkedView: "MenuView", navigateTo: AnyView(MenuView(viewModel: MenuViewModel())))
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
                     NavigationLink(destination: mainViewModel.goToView.navigationBarBackButtonHidden(true), isActive: $mainViewModel.isNavEnabled, label: { EmptyView() })
                 })
             })
     }
 }

 struct DropdownNavigationMenu_Previews: PreviewProvider {
     static var previews: some View {
         DropdownNavigationMenu()
     }
 }

 struct Dropdown: View {
     var options: [String]
     var onOptionSelected: ((_ option: String) -> Void)?
     
     var body: some View {
         ScrollView {
             VStack(alignment: .leading, spacing: 0) {
                 ForEach(self.options, id: \.self) { option in
                     DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                 }
             }
         }
         .frame(minHeight: CGFloat(options.count) * 30, maxHeight: 250)
         .padding(.vertical, 5)
         .background(Color("sophosBC"))
         .cornerRadius(5)
         .overlay(
             RoundedRectangle(cornerRadius: 5)
                 .stroke(Color("violet_UI"), lineWidth: 1)
         )
     }
 }

 struct DropdownRow: View {
     
     var option: String
     var onOptionSelected: ((_ option: String) -> Void)?
     
     var body: some View {
         
         Button(action: {
             if let onOptionSelected = self.onOptionSelected {
                 onOptionSelected(self.option)
             }
         }, label: {
             HStack {
                 Spacer()
                 Text(self.option)
                     .font(.callout)
                     .foregroundColor(Color("violet_UI"))
                     .multilineTextAlignment(.center)
             }
         })
         .padding(.horizontal, 16)
         .padding(.vertical, 5)
     }
 }

 */
