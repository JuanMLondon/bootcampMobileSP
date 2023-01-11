//
//  OfficesView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import _MapKit_SwiftUI
import SwiftUI


struct OfficesView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = OfficesViewModel.shared.self
    @StateObject var getOfficesService = GetOfficesService.shared.self
    @StateObject var manager = LocationManager()
    @State var tracking:MapUserTrackingMode = .follow
    @State var viewSelection: String?
    @State var officeLocations: [OfficeModel] = [] //@State var officeLocations: [OfficeModel]?
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color("sophosBC")
                //Color(.systemGreen)
                VStack {
                    CustomMenuBar()
                        .padding(.top, 75)
                        .padding(.horizontal, 20)
                    
                    Map(coordinateRegion: $manager.region, interactionModes: MapInteractionModes.all, showsUserLocation: true, userTrackingMode: $tracking)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.viewModel.currentViewSelection = MenuViewModel().currentViewSelection
                CustomMenuBarVM().previousView = MenuViewModel().currentViewSelection
                print("Current selection state (from OfficesViewVM): \(String(describing: self.$viewModel.currentViewSelection))")
                self.officeLocations =  getOfficesService.getOffices(completion: { success in })!
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.officeLocations = self.getOfficesService.getOfficesList()
                    print("Test officeLocations from OfficesView: \(self.officeLocations)")
                })
            }
            /*.onDisappear() {
                dismiss()
            }*/
        }
    }
}

struct OfficesView_Previews: PreviewProvider {
    static var previews: some View {
        OfficesView(viewModel: OfficesViewModel())
    }
}
