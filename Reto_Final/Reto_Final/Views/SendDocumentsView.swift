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
        
        //NavigationView {
            ZStack {
                //Color("sophosBC")
                Color(.systemOrange)
                    .toolbar {
                        ToolbarItem(placement: .principal, content: {
                            VStack{
                                
                                HStack{
                                    Spacer()
                                    
                                    Button {
                                        print("Menu button was tapped")
                                    } label: {
                                        
                                        DropdownNavigationMenu()
                                        
                                    }
                                }
                                
                                HStack{
                                    Text("Envío de documentación")
                                    //navigationBarTitle("Menú", displayMode: .inline)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            .padding(.top, 55)
                        })
                    }
                    .navigationTitle("Title")
                    .onAppear() {
                        self.viewModel.currentViewSelection = MenuViewModel().currentViewSelection
                        print("Current view selection state (from ViewModel): \(String(describing: self.$viewModel.currentViewSelection))")
                        print("Current view selection state (from View): \(String(describing: self.viewSelection))")
                    }
            }
            .edgesIgnoringSafeArea(.all)
        //}
        Text("Envío de documentación")
    }
}

struct SendDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        SendDocumentsView(viewModel: SendDocumentsViewModel())
    }
}
