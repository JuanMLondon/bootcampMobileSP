//
//  OfficesViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class OfficesViewModel: ObservableObject {
    
    static let sharedOfficesViewVM = OfficesViewModel()
    
    @ObservedObject var menuViewModel = MenuViewModel.shared.self
    
    @Published var currentViewSelection: String?
    
    init() { }
    
}
