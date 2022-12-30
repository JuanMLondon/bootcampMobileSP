//
//  OfficesView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct OfficesView: View {
    
    @ObservedObject var viewModel = OfficesViewModel.sharedOfficesViewVM.self
    @State var viewSelection: String?
    
    var body: some View {
        
        NavigationView {
            ZStack {
                //Color("sophosBC")
                Color(.systemGreen)
                VStack {
                    CustomMenuBar()
                        .padding(.top, 75)
                        .padding(.horizontal, 20)
                    Spacer()
                    Text("View the location of Sophos' offices in the current city")
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.viewModel.currentViewSelection = MenuViewModel().currentViewSelection
                print("Current view selection state (from ViewModel): \(String(describing: self.$viewModel.currentViewSelection))")
                print("Current view selection state (from View): \(String(describing: self.viewSelection))")
            }
        }
    }
}

struct OfficesView_Previews: PreviewProvider {
    static var previews: some View {
        OfficesView(viewModel: OfficesViewModel())
    }
}
