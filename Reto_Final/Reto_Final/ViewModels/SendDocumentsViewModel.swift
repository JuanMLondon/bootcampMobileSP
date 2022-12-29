//
//  SendDocumentsViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class SendDocumentsViewModel: ObservableObject {
    
    static let sharedSendDocumentsViewVM = SendDocumentsViewModel()
    
    @StateObject var menuViewModel = MenuViewModel.sharedMenuViewVM.self
    
    @Published var currentViewSelection: String? = MenuViewModel().currentViewSelection
    
    init() { }
    
}
