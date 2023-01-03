//
//  ViewDocumentsViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class ViewDocumentsViewModel: ObservableObject {
    
    static let shared = ViewDocumentsViewModel()
    
    @ObservedObject var menuViewModel = MenuViewModel.shared.self
    
    @Published var currentViewSelection: String?
    
    init() { }
    
}
