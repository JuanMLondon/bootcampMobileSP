//
//  CompressUIImage.swift
//  Reto_Final
//
//  Created by JML on 2/01/23.
//

import SwiftUI

struct compresUIImage {
    let image = UIImage()
    
    func resizeImage(image: UIImage) -> UIImage {
            let resizedImage = image.aspectFittedToHeight(200)

            return resizedImage
    }
    
    func compressImage(image: UIImage) -> UIImage {
            let resizedImage = image.aspectFittedToHeight(200)
            resizedImage.jpegData(compressionQuality: 0.2) // Add this line

            return resizedImage
    }
}


extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
