//
//  ViewDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct ViewDocumentsView: View {
    
    @ObservedObject var viewModel = ViewDocumentsViewModel.sharedViewDocumentsViewVM.self
    @State var viewSelection: String?
    
    @State private var goToView: AnyView?
    @State private var isActive = false
    
    var body: some View {
        
        //NavigationView {
        ZStack {
            //Color("sophosBC")
            Color(.systemRed)
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
                                Text("Ver documentos")
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
        Text("Ver documentos enviados")
    }
}

struct ViewDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocumentsView(viewModel: ViewDocumentsViewModel())
    }
}
