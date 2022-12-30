//
//  MenuViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class MenuViewModel: ObservableObject {
    
    static let sharedMenuViewVM = MenuViewModel()
    
    
    @ObservedObject var networkService = NetworkService.shared.self
    @Published var currentViewSelection: String?
    
    init() { }
    
    func getLoggedUser() -> UserModel{
        return networkService.getLoggedInUser()
    }
}

struct menuItemView: View {
    
    let linkedView: String
    let menuTitle: String
    let menuIconName: String
    let colorScheme: String
    let colorFill: String
    let frameColor: String
    let lighterButtonColor: String
    let lighterButtonFill: String
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .fill(Color(colorFill))
            .frame(minHeight: 75.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(frameColor), lineWidth: 2))
            .overlay(HStack {
                
                Image(systemName: menuIconName)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25.0, height: 25.0)
                    .foregroundColor(Color(colorScheme))
                    .padding(.leading, 30)
                    .padding(.bottom, 30)
                
                Text(menuTitle)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(colorScheme))
                    .padding(.leading, 5)
                    .padding(.bottom, 35)
                
                Spacer()
                
                NavButton(linkedView: linkedView, colorScheme: colorScheme, lighterButtonColor: lighterButtonColor, lighterButtonFill: lighterButtonFill)
            })
            .padding(.vertical, 3)
            .padding(.horizontal, 25)
    }
}

struct NavButton: View {
    
    @ObservedObject var viewModel = MenuViewModel.sharedMenuViewVM.self
    @State var viewSelection: String?
    let linkedView: String
    let colorScheme: String
    let lighterButtonColor: String
    let lighterButtonFill: String
    
    var body: some View {
        
        switch linkedView {
            
        case "SendDocuments":
            
            MenuNavLink(viewSelection: viewSelection, destinationView: AnyView(SendDocumentsView(viewModel: SendDocumentsViewModel())), linkedView: linkedView, colorScheme: colorScheme, lighterButtonColor: lighterButtonColor, lighterButtonFill: lighterButtonFill)
            
        case "ViewDocuments":
            
            MenuNavLink(viewSelection: viewSelection, destinationView: AnyView(ViewDocumentsView(viewModel: ViewDocumentsViewModel())), linkedView: linkedView, colorScheme: colorScheme, lighterButtonColor: lighterButtonColor, lighterButtonFill: lighterButtonFill)
            
        case "Offices":
            
            MenuNavLink(viewSelection: viewSelection, destinationView: AnyView(OfficesView(viewModel: OfficesViewModel())), linkedView: linkedView, colorScheme: colorScheme, lighterButtonColor: lighterButtonColor, lighterButtonFill: lighterButtonFill)
            
        default:
            NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(false), tag: linkedView, selection: $viewSelection, label: { EmptyView() })
        }
    }
}

struct MenuNavLink: View {
    
    @ObservedObject var viewModel = MenuViewModel.sharedMenuViewVM.self
    @State var viewSelection: String?
    let destinationView: any View
    let linkedView: String
    let colorScheme: String
    let lighterButtonColor: String
    let lighterButtonFill: String
    
    init(viewSelection: String? = nil, destinationView: AnyView, linkedView: String, colorScheme: String, lighterButtonColor: String, lighterButtonFill: String) {
        //self.viewSelection = viewSelection
        self.destinationView = destinationView
        self.linkedView = linkedView
        self.colorScheme = colorScheme
        self.lighterButtonColor = lighterButtonColor
        self.lighterButtonFill = lighterButtonFill
    }
    
    var body: some View {
        
        NavigationLink(destination: AnyView(destinationView).navigationBarBackButtonHidden(true), tag: linkedView, selection: $viewSelection, label: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(lighterButtonFill))
                .frame(width: 110, height: 28.0)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(lighterButtonColor), lineWidth: 1))
                .overlay(HStack {
                    Button("Ingresar") {
                        buttonAction(viewSelection: viewSelection ?? "MenuView")
                    }
                    .foregroundColor(Color(colorScheme))
                    .padding(.leading, 10)
                    .font(.footnote)
                    
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color(colorScheme))
                        .padding(.trailing, 5)
                })
                .padding(.trailing, 15)
                .padding(.top, 30)
        })
    }
    
    func buttonAction(viewSelection: String?) {
        DispatchQueue.main.async {
            self.viewModel.currentViewSelection = self.linkedView
            self.viewSelection = self.viewModel.currentViewSelection
            print("Go to view (Stage 2A): \(String(describing: self.viewSelection!))")
            print("Go to view (Stage 2B): \(String(describing: self.viewModel.currentViewSelection!))")
            print("Go to view (Stage 2C): \(String(describing: MenuViewModel().currentViewSelection))")
        }
    }
}


