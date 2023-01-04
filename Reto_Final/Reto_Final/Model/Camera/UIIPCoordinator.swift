//
//  Coordinator.swift
//  Reto_Final
//
//  Created by JML on 3/01/23.
//

import UIKit

class UIIPCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: UIImagePickerModel
    
    init(parent: UIImagePickerModel) {
        self.parent = parent
    }
    
    /*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        //guard let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else { return }
        
        print("\(info)")
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
     }*/
    
    /*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.parent.selectedImage = image
        }
        self.parent.isPresented.wrappedValue.dismiss()
    }
     */
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel pressed")
        self.parent.isPresented.wrappedValue.dismiss()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.parent.selectedImage = image
        }
        self.parent.isPresented.wrappedValue.dismiss()
    }
    
    /*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            //UIImageWriteToSavedPhotosAlbum(image, <#T##completionTarget: Any?##Any?#>, <#T##completionSelector: Selector?##Selector?#>, <#T##contextInfo: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>)
            self.parent.selectedImage = image
        }
        
        /*
        if let image = UIImage(named: "example.png") {
            if let data = image.pngData() {
                let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
                try? data.write(to: filename)
            }
        }
         */
        
        /*
        if let image = UIImage(named: "example.jpg") {
            if let data = image.jpegData(compressionQuality: 0.8) {
                let filename = getDocumentsDirectory().appendingPathComponent("copy.jpg")
                try? data.write(to: filename)
            }
        }
         */
        self.parent.isPresented.wrappedValue.dismiss()
    }
     */
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
