//
//  PHPCoordinator.swift
//  Reto_Final
//
//  Created by JML on 3/01/23.
//

import PhotosUI

class PHPCoordinator: NSObject, PHPickerViewControllerDelegate {
    var parent: ImagePHPickerModel

    init(_ parent: ImagePHPickerModel) {
        self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let provider = results.first?.itemProvider else { return }

        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                self.parent.selectedImage = image as? UIImage
                self.parent.imageData = image as? UIImage
                //self.parent.base64SelectedImage = SendDataService().encodeImgBase64(image: (image as? UIImage)!)
            }
        }
    }
}
