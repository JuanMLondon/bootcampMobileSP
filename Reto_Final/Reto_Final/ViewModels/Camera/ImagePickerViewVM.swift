//
//  ImagePickerModel.swift
//  Reto_Final
//
//  Created by JML on 11/01/23.
//

import SwiftUI

class ImagePickerViewVM: ObservableObject {
    
    // Singleton
    static let shared = ImagePickerViewVM()
    
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var showCameraAlert = false
    @Published var cameraError: Picker.CameraErrorType?
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkCameraPermissions()
            }
            showPicker = true
            
        } catch {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
}
