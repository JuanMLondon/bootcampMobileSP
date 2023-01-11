//
//  SendDocumentsViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class SendDocumentsViewModel: ObservableObject {
    
    // Singleton
    static let shared = SendDocumentsViewModel()
    
    @ObservedObject var menuViewModel = MenuViewModel.shared.self
    @ObservedObject var sendDataService = SendDataService.shared.self
    @Published var currentViewSelection: String? = MenuViewModel().currentViewSelection
    
    @Published var hasError: Bool = false
    @Published var working: Bool = false
    @Published var sent: Bool = false
    
    @Published var result: Bool?
    
    var typeId: String = "001"
    var idNumber: String = ""
    var name: String = ""
    var lastname: String = ""
    var email: String = ""
    var city: String = ""
    var doctype: String = ""
    var encodedDoc: String? = ""
    
    init() { }
    
    func setParameters() {
        SendDataService.shared.typeId = self.typeId
        SendDataService.shared.idNumber = self.idNumber
        SendDataService.shared.name = self.name
        SendDataService.shared.lastname = self.lastname
        SendDataService.shared.email = self.email
        SendDataService.shared.city = self.city
        SendDataService.shared.doctype = self.doctype
        SendDataService.shared.encodedDoc = self.encodedDoc ?? ""
    }
    
    func getResult() -> Bool {
        let result = sendDataService.result?.put ?? nil
        if result == nil {
            return false
        }
        return true
    }
    
    func retrieveEmail() -> String? {
        let email = LoginViewModel().defaults.string(forKey: "LastUserEmail") ?? ""
        self.email = email
        return email
    }
    
    func setParameters(email: String) {
        self.email = email
        GetDocumentsService.shared.email = email
    }
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
