//
//  ViewDocumentsViewModel.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

class ViewDocumentsViewModel: ObservableObject {
    
    // Singleton
    static let shared = ViewDocumentsViewModel()
    
    @ObservedObject var menuViewModel = MenuViewModel.shared.self
    @Published var currentViewSelection: String?
    @Published var docID: String?
    @Published var email: String?
    @Published var attachedImage: UIImage?
    
    init() { }
    
    func retrieveEmail() -> String? {
        let email = LoginViewModel().defaults.string(forKey: "LastUserEmail") ?? ""
        self.email = email
        return email
    }
    
    func setEmail(email: String) {
        self.email = email
        GetDocumentsService.shared.email = email
        GetDataService.shared.email = email
    }
    
    func setDocID(docID: String) {
        self.docID = docID
        GetDataService.shared.docID = docID
    }
    
    func decodeBase64Img(base64String: String) -> UIImage? {
        var image: UIImage?
        let newImageData = Data(base64Encoded: base64String)
        if let newImageData = newImageData {
            image = UIImage(data: newImageData)
            self.attachedImage = image!
            return image!
        }
        return nil
    }
}
