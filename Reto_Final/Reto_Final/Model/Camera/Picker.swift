//
//  Picker.swift
//  Reto_Final
//
//  Created by JML on 11/01/23.
//

import SwiftUI
import AVFoundation

enum Picker {
    enum Source: String {
        case library, camera
    }
    
    enum PickerError: Error, LocalizedError {
        case unavailable
        case restricted
        case denied
        
        var errorDescription: String? {
            switch self {
            case .unavailable:
                //return NSLocalizedString("The cameras on this device are not available", comment: "")
                return NSLocalizedString("Las cámaras en este dispositivo no están disponibles.", comment: "")
            case .restricted:
                //return NSLocalizedString("You're not allowed to access capture devices.", comment: "")
                return NSLocalizedString("No está autorizado para acceder a los dispositivos de captura.", comment: "")
            case .denied:
                //return NSLocalizedString("You have denied permission for media capture. Please open \"Settings > Privacy > Camera\" and grant access to this App.", comment: "")
                return NSLocalizedString("Usted ha negado el permiso para acceder a los dispositivos de captura. Por favor abra \"Configuración > Privacidad > Cámara\" y otorgue el permiso a esta App.", comment: "")
            }
        }
    }
    
    /*static func checkCameraPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }*/
    
    static func checkCameraPermissions()throws {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .denied:
                throw PickerError.denied
            case .restricted:
                throw PickerError.restricted
            default:
                break
            }
        } else {
            throw PickerError.unavailable
        }
    }
    
    struct CameraErrorType {
        let error: Picker.PickerError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
}
