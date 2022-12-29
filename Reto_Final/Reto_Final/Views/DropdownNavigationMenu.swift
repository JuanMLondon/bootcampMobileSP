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
    @State private var selectedOption: String?
    @State var viewSelection: String?
    @State var isNavEnabled = false
    
    var options: [String] = ["Menú principal", "Enviar documentos", "Ver documentos", "Oficinas", "Cerrar sesión"]
    var onOptionSelected: ((_ option: String) -> Void)?
    private let buttonHeight: CGFloat = 45
    
    @State var goToView: AnyView?
    
    var body: some View {
            // Default Dropdown Menu
            Menu(content: {
                
                Dropdown(options: self.options) { option in
                    //shouldShowDropdown = false // Needed for customized Dropdown Menu
                    self.selectedOption = option
                    self.onOptionSelected?(option)
                    
                    switch selectedOption! {
                        
                    case "Enviar documentos":
                        self.isNavEnabled = true
                        let linkedView = "SendDocuments"
                        self.viewSelection = linkedView
                        self.goToView = AnyView(SendDocumentsView(viewModel: SendDocumentsViewModel()))
                        self.viewModel.currentViewSelection = viewSelection!
                        print("Go to view Stage 1: \(String(describing: viewModel.currentViewSelection))")
                        
                    case "Ver documentos":
                        self.isNavEnabled = true
                        let linkedView = "ViewDocuments"
                        self.viewSelection = linkedView
                        self.goToView = AnyView(ViewDocumentsView(viewModel: ViewDocumentsViewModel()))
                        self.viewModel.currentViewSelection = viewSelection!
                        print("Go to view Stage 1: \(String(describing: viewModel.currentViewSelection))")

                    case "Oficinas":
                        self.isNavEnabled = true
                        let linkedView = "Offices"
                        self.viewSelection = linkedView
                        self.goToView = AnyView(OfficesView(viewModel: OfficesViewModel()))
                        self.viewModel.currentViewSelection = viewSelection!
                        print("Go to view Stage 1: \(String(describing: viewModel.currentViewSelection))")
                        
                        
                    default:
                        self.isNavEnabled = true
                        let linkedView = "Offices"
                        self.viewSelection = linkedView
                        self.goToView = AnyView(MenuView(viewModel: MenuViewModel()))
                        self.viewModel.currentViewSelection = viewSelection!
                        print("Go to view Stage 1: \(String(describing: viewModel.currentViewSelection))")
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

