//
//  UIImagePickerModel.swift
//  Reto_Final
//
//  Created by JML on 2/01/23.
//

import SwiftUI

struct UIImagePickerModel: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var isPresented
    
    @Binding var selectedImage: UIImage?
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = self.sourceType
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> UIIPCoordinator {
        return Coordinator(parent: self)
    }
    
    func save() {
        guard let selectedImage = selectedImage else { return }

        let imageSaver = SaveImageToLibrary()

        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = {
            print("Error! \($0.localizedDescription)")
        }

        imageSaver.writeToPhotoAlbum(image: selectedImage)
    }
    
}

