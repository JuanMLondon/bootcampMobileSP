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
        
        NavigationView {
            ZStack {
                //Color("sophosBC")
                Color(.systemPink)
                VStack {
                    CustomMenuBar()
                        .padding(.top, 75)
                        .padding(.horizontal, 20)

                    Text("View a list of sent documents")
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.viewModel.currentViewSelection = MenuViewModel().currentViewSelection
                CustomMenuBarVM().previousView = MenuViewModel().currentViewSelection
                //print("Current view selection state (from ViewModel): \(String(describing: self.$viewModel.currentViewSelection))")
            }
        }
    }
}

struct ViewDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocumentsView(viewModel: ViewDocumentsViewModel())
    }
}
