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
    
    var typeId: String = ""
    var idNumber: String = ""
    var name: String = ""
    var lastname: String = ""
    var email: String = ""
    var city: String = ""
    var doctype: String = ""
    var encodedDoc: String = ""
    
    init() { }
}

struct DropdownList: View {
    
    @State private var selectedOption: String?
    @State var dropdownLabel: String
    var menuItems: [String]
    var onOptionSelected: ((_ option: String) -> Void)?
    
    var body: some View {
        Menu(content: {
            Dropdown(options: self.menuItems) { option in
                self.selectedOption = option
                self.onOptionSelected?(option)
                self.dropdownLabel = self.selectedOption ?? ""
            }
        }, label: {
            HStack{
                Text(dropdownLabel)
                
                Spacer()
                
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 13, height: 8)
                    .foregroundColor(Color("black_UI"))
            }
        })
    }
}
