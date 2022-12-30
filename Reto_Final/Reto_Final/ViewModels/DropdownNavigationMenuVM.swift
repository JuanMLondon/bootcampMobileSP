//
//  DropdownNavigationMenuVM.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import SwiftUI

class DropdownNavigationMenuVM: ObservableObject {
    
    static let sharedDropdownNMVM = DropdownNavigationMenuVM()
    
    @ObservedObject var viewModel = MenuViewModel.sharedMenuViewVM.self
    @Published var viewSelection: String?
    @Published var isNavEnabled = false
    @Published var goToView: AnyView?
    
    func navigateAction(linkedView: String, navigateTo: AnyView) {
        self.isNavEnabled = true
        let view = linkedView
        self.viewSelection = view
        self.goToView = navigateTo
        self.viewModel.currentViewSelection = viewSelection!
        print("Go to view: \(String(describing: viewModel.currentViewSelection))")
    }
}
