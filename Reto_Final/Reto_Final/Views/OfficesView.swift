//
//  OfficesView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

 import SwiftUI

struct OfficesView: View {
    
    @ObservedObject private var model = FrameViewModel()
    //@StateObject private var model = FrameViewModel()
    
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
                    //FrameView(image: nil)
                    FrameView(image: model.frame)
                        .frame(maxWidth: .infinity, minHeight: 500)
                        .edgesIgnoringSafeArea(.all)
                    ErrorView(error: model.error)
                    
                    /*ControlView(
                        comicSelected: $model.comicFilter,
                        monoSelected: $model.monoFilter,
                        crystalSelected: $model.crystalFilter)*/
                    
                    Text("View the location of Sophos' offices in the current city")
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

struct OfficesView_Previews: PreviewProvider {
    static var previews: some View {
        OfficesView(viewModel: OfficesViewModel())
    }
}
