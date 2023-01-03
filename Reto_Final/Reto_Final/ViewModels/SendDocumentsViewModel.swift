//
//  SendDocumentsViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class SendDocumentsViewModel: ObservableObject {
    
    static let shared = SendDocumentsViewModel()
    
    @ObservedObject var menuViewModel = MenuViewModel.shared.self
    @ObservedObject var sendDataService = SendDataService.shared.self
    @Published var currentViewSelection: String? = MenuViewModel().currentViewSelection
    
    var typeId: String = ""
    var idNumber: String = ""
    var name: String = ""
    var lastname: String = ""
    var email: String = ""
    var city: String = ""
    var doctype: String = ""
    var image: UIImage?
    var encodedDoc: String?
    
    init() { }
    
    func getImage() -> UIImage? {
        if SendDocumentsView().image != nil {
            let image = SendDocumentsView().image
            return image!
        }
        return nil
    }
    
    func getBase64() -> String? {
        if SendDocumentsView().image != nil {
            self.image = SendDocumentsView().image
            self.encodedDoc = SendDataService().encodeImgBase64(image: image!)
            return self.encodedDoc
        }
        return nil
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
