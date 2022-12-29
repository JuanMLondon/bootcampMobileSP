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
        
        //NavigationView {
            ZStack {
                //Color("sophosBC")
                Color(.systemGreen)
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
                                    Text("Localización oficinas")
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
        Text("Localización oficinas Sophos")
    }
}

struct OfficesView_Previews: PreviewProvider {
    static var previews: some View {
        OfficesView(viewModel: OfficesViewModel())
    }
}
