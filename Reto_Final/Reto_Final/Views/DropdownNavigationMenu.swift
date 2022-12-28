//
//  DropdownNavigationMenu.swift
//  Reto_Final
//
//  Created by JML on 27/12/22.
//

import SwiftUI

struct DropdownNavigationMenu: View {
    
    @ObservedObject var viewModel = MenuViewModel.sharedMenuViewVM.self
    @State private var shouldShowDropdown = true
    @State private var selectedOption: String? = nil
    @State var viewSelection: String? = "MenuView"
    @State var isNavEnabled = true
    
    var options: [String] = ["Menú principal", "Enviar documentos", "Ver documentos", "Oficinas", "Cerrar sesión"]
    var onOptionSelected: ((_ option: String) -> Void)?
    private let buttonHeight: CGFloat = 45
    
    @State var goToView: AnyView?
    
    var body: some View {
        
        NavigationView{
            // Default Dropdown Menu
            Menu(content: {
                
                Dropdown(options: self.options) { option in
                    //shouldShowDropdown = false // Needed for customized Dropdown Menu
                    selectedOption = option
                    self.onOptionSelected?(option)
                    viewModel.currentViewSelection = viewSelection!
                    
                    switch selectedOption! {
                        
                    case "Enviar documentos":
                        let linkedView = "SendDocuments"
                        self.viewSelection = linkedView
                        self.goToView = AnyView(SendDocumentsView(viewModel: SendDocumentsViewModel()))
                        self.viewModel.currentViewSelection = viewSelection ?? "MenuView"
                        MenuNavLink(destinationView: goToView ?? AnyView(SendDocumentsView(viewModel: SendDocumentsViewModel())), linkedView: linkedView, colorScheme: "", lighterButtonColor: "", lighterButtonFill: "").buttonAction(viewSelection: self.viewSelection).self
                        
                        print("Go to view Step 1: \(String(describing: viewModel.currentViewSelection))")
                        
                    case "Ver documentos":
                        
                        let linkedView = "ViewDocuments"
                        self.viewSelection = linkedView
                        //NavigationLink(destination: ViewDocumentsView(viewModel: ViewDocumentsViewModel()).navigationBarBackButtonHidden(false), tag: linkedView, selection: $viewSelection, label: { EmptyView()} )
                        viewModel.currentViewSelection = viewSelection ?? "MenuView"
                        print("Go to view Step 1: \(String(describing: viewModel.currentViewSelection))")
                        
                        self.goToView = AnyView(ViewDocumentsView(viewModel: ViewDocumentsViewModel()))
                        
                        NavigationLink(destination: AnyView(goToView).navigationBarBackButtonHidden(false), isActive: $isNavEnabled, label: { EmptyView() })
                        print("Prueba goto view: \(String(describing: goToView!))")
                        
                    case "Oficinas":
                        let linkedView = "Offices"
                        self.viewSelection = linkedView
                        //NavigationLink(destination: OfficesView(viewModel: OfficesViewModel()).navigationBarBackButtonHidden(false), tag: linkedView, selection: $viewSelection, label: { EmptyView() })
                        viewModel.currentViewSelection = viewSelection ?? "MenuView"
                        print("Go to view Step 1: \(String(describing: viewModel.currentViewSelection))")
                        
                        let colorScheme: String = ""
                        let lighterButtonColor: String = ""
                        let lighterButtonFill: String = ""
                        
                        let nav = MenuNavLink(viewSelection: viewSelection, destinationView: AnyView(OfficesView(viewModel: OfficesViewModel())), linkedView: linkedView, colorScheme: colorScheme, lighterButtonColor: lighterButtonColor, lighterButtonFill: lighterButtonFill)
                        
                        DispatchQueue.main.async {
                            nav.buttonAction(viewSelection: viewSelection)
                        }
                        
                    default:
                        let linkedView = "MenuView"
                        self.viewSelection = linkedView
                        //NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(false), tag: linkedView, selection: $viewSelection, label: { EmptyView() })
                        viewModel.currentViewSelection = viewSelection ?? "MenuView"
                        print("Go to view Step 1: \(String(describing: viewModel.currentViewSelection))")
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
                /*
                Image("menu_icon")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40.0, height: 36.0)
                 */
                
            })
            
            /*// Customized Dropdown Menu (Has problems overlaying to ZStacks)
            Button(action: {
                self.shouldShowDropdown.toggle()
            }, label:{
                HStack {
                    Spacer()
                    Image("menu_icon")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40.0, height: 36.0)
                        .padding(.leading, 40)
                }
            })
            .padding(.horizontal)
            .cornerRadius(5)
            .frame(width: 180, height: self.buttonHeight)
            /*.overlay(
             RoundedRectangle(cornerRadius: 5)
             .stroke(Color("violet_UI"), lineWidth: 1)
             )
             */
            .overlay(
                VStack {
                    if self.shouldShowDropdown {
                        Spacer(minLength: buttonHeight + 10)
                        Dropdown(options: self.options) { option in
                            shouldShowDropdown = false
                            selectedOption = option
                            self.onOptionSelected?(option)
                        }
                    }
                }, alignment: .topLeading
            )
            .background(
                RoundedRectangle(cornerRadius: 5).fill(Color("sophosBC"))
            )
            */
            
        }
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
