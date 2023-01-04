//
//  SendDataService.swift
//  Reto_Final
//
//  Created by JML on 3/01/23.
//

import SwiftUI

class SendDataService: ObservableObject {
    
    static let shared = SendDataService()
    
    @Published var working: Bool?
    @Published var failed: Bool = false
    @Published var success: Bool = false
    
    init() { }
    
    func encodeImgBase64(image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 0.1)
        let base64String = imageData?.base64EncodedString()
        print(base64String ?? "")
        return base64String!
    }
    
    func decodeBase64Img(base64String: String) -> UIImage? {
        var image: UIImage?
        let newImageData = Data(base64Encoded: base64String)
        if let newImageData = newImageData {
            image = UIImage(data: newImageData)
            return image!
        }
        return nil
    }
}
