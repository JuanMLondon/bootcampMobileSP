//
//  ViewDocumentsViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class ViewDocumentsViewModel: ObservableObject {
    
    static let sharedViewDocumentsViewVM = ViewDocumentsViewModel()
    
    @StateObject var menuViewModel = MenuViewModel.sharedMenuViewVM.self
    
    @Published var currentViewSelection: String?
    
    init() { }
    
}
