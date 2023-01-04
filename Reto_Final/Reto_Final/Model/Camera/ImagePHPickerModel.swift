//
//  ImagePickerView.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import PhotosUI
import SwiftUI

struct ImagePHPickerModel: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    var imageData: UIImage?
    //var base64SelectedImage: String?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> PHPCoordinator {
        PHPCoordinator(self)
    }
}

