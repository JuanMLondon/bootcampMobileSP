//
//  SendDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct SendDocumentsView: View {
    
    @ObservedObject var viewModel = SendDocumentsViewModel.sharedSendDocumentsViewVM.self
    
    //@State private var shouldShowDropdown = true // Needed for customized Dropdown Menu
    @State private var selectedOption: String?
    @State var viewSelection: String?
    @State var isNavEnabled = false
    
    var options: [String] = ["Menú principal", "Enviar documentos", "Ver documentos", "Oficinas", "Cerrar sesión"]
    var onOptionSelected: ((_ option: String) -> Void)?
    private let buttonHeight: CGFloat = 45
    
    @State var goToView: AnyView?
    
    var body: some View {
        
        NavigationView {
            ZStack {
                //Color("sophosBC")
                Color(.systemPurple)
                VStack {
                    CustomMenuBar()
                        .padding(.top, 75)
                        .padding(.horizontal, 20)
                    Spacer()
                    Text("Prepare a document for sending")
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.viewModel.currentViewSelection = MenuViewModel().currentViewSelection
                
                CustomMenuBar().previousView = MenuViewModel().currentViewSelection
                
                print("Current view selection state (from ViewModel): \(String(describing: self.$viewModel.currentViewSelection))")
                print("Current view selection state (from View): \(String(describing: self.viewSelection))")
            }
        }
    }
}

struct SendDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        SendDocumentsView(viewModel: SendDocumentsViewModel())
    }
}
