//
//  FrameViewModel.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import CoreImage

class FrameViewModel: ObservableObject {
    // 1 frame will hold the images that FrameView will display.
    @Published var error: Error?
    @Published var frame: CGImage?
    
    //Needed for applying filters
    var comicFilter = false
    var monoFilter = false
    var crystalFilter = false
    

    private let context = CIContext()
    
    // 2 Data used to generate frame will come from FrameManager.
    private let cameraManager = CameraManager.shared
    private let frameManager = FrameManager.shared
    
    init() {
        setupSubscriptions()
    }
    // 3 You’ll add all your Combine pipelines to setupSubscriptions() to keep them in one place.
    func setupSubscriptions() {
        // B1 Tap into the Publisher provided automatically for the published CameraManager.error.
        cameraManager.$error
        // B2 Receive it on the main thread.
            .receive(on: RunLoop.main)
        // B3 Map it to itself, because otherwise Swift will complain in the next line that you can’t assign a CameraError to an Error.
            .map { $0 }
        // B4 Assign it to error.
            .assign(to: &$error)
        // To transform the CVPixelBuffer data, FrameManager provides to a CGImage your FrameView requires, you’ll harness the power of Combine! You made this possible when you declared FrameManager.current @Published.
        // 4 Tap into the Publisher that was automatically created for you when you used @Published.
        frameManager.$current
        // 5 Receive the data on the main run loop. It should already be on main, but just in case, it doesn’t hurt to be sure.
            .receive(on: RunLoop.main)
        // 6 Convert CVPixelBuffer to CGImage and filter out all nil values through compactMap.
            .compactMap { buffer in
                return CGImage.create(from: buffer)
                
                //Needed for applying filters
                guard let image = CGImage.create(from: buffer) else {
                  return nil
                }
                
                var ciImage = CIImage(cgImage: image)

                if self.comicFilter {
                  ciImage = ciImage.applyingFilter("CIComicEffect")
                }

                if self.monoFilter {
                  ciImage = ciImage.applyingFilter("CIPhotoEffectNoir")
                }

                if self.crystalFilter {
                  ciImage = ciImage.applyingFilter("CICrystallize")
                }

                return self.context.createCGImage(ciImage, from: ciImage.extent)
                
            }
        // 4 Assign the output of the pipeline — which is, itself, a publisher — to your published frame.
            .assign(to: &$frame)
    }
}
