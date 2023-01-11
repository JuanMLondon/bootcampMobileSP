//
//  OfficesViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import _MapKit_SwiftUI
import SwiftUI

class OfficesViewModel: ObservableObject {
    
    // Singleton
    static let shared = OfficesViewModel()
    
    @ObservedObject var getOfficesService = GetOfficesService.shared.self
    @ObservedObject var menuViewModel = MenuViewModel.shared.self
    @Published var currentViewSelection: String?
    @Published var officeLocations: [OfficeModel]?
    
    init() { }
    
    func getOfficesData() -> [OfficeModel] {
        self.officeLocations = self.getOfficesService.getOfficesList()
        print("Test from OfficesViewVM: \(officeLocations)")
        print("Test from OfficesViewVM Iterator):")
        self.officeLocations!.forEach({print($0.IdOficina, $0.Nombre, $0.Ciudad, $0.LongitudeDouble, $0.LatitudeDouble)})
        return self.officeLocations!
    }
}
