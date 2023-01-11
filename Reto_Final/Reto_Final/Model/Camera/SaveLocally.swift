//
//  SaveLocally.swift
//  Reto_Final
//
//  Created by JML on 2/01/23.
//

//import UIKit
import SwiftUI

class SaveLocally {
    
    enum storageType {
        case userDefaults, fileSystem
    }
    
    var savedImageDisplayImageView: UIImageView!
    
    private func store(image: UIImage, forKey key: String, withStorageType storageType: storageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                // Save to disk
                if let filePath = filePath(forKey: key) {
                    do  {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("An error ocurred while saving the file: ", err)
                    }
                }
            case .userDefaults:
                // Save to user defaults
                UserDefaults.standard.set(pngRepresentation, forKey: key)
            }
        }
    }
    
    private func retrieveImage(forKey key: String, inStorageType storageType: storageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            // Retrieve image from disk
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            // Retrieve image from user defaults
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
               let image = UIImage(data: imageData) {
                
                return image
            }
        }
        return nil
    }
    
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    @objc
    private func save() {
        if let buildingImage = UIImage(named: "building") {
            DispatchQueue.global(qos: .background).async {
                self.store(image: buildingImage, forKey: "buildingImage", withStorageType: .fileSystem)
            }
        }
    }
    
    @objc
    private func display() {
        DispatchQueue.global(qos: .background).async {
            if let savedImage = self.retrieveImage(forKey: "buildingImage", inStorageType: .fileSystem) {
                DispatchQueue.main.async {
                    self.savedImageDisplayImageView.image = savedImage
                }
            }
        }
    }
}
