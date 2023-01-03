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
    
    //Func Encode image Base64
    
    /*
     extension UIImage {
         var base64: String? {
             self.jpegData(compressionQuality: 1)?.base64EncodedString()
         }
     }

     extension String {
         var imageFromBase64: UIImage? {
             guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
                 return nil
             }
             return UIImage(data: imageData)
         }
     }

     let img = //get UIImage from wherever
     let base64 = img.base64
     let rebornImg = base64?.imageFromBase64
     */
    
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
