//
//  FrameManager.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

//FrameManager will be responsible for receiving data from CameraManager and publishing a frame for use elsewhere in the app. This logic could technically be integrated into CameraManager, but splitting these up also divides the responsibility a bit more clearly. This will be especially helpful if you choose to add more functionality — such as preprocessing or synchronization — to FrameManager in the future.

import AVFoundation

// 1 Define the class and have it inherit from NSObject and conform to ObservableObject. FrameManager needs to inherit from NSObject because FrameManager will adopt AVCaptureSession‘s video output. This is a requirement, so you’re just getting a head start on it.
class FrameManager: NSObject, ObservableObject {
    // 2 Make the frame manager a singleton.
      static let shared = FrameManager()
      // 3 Add a published property for the current frame received from the camera. This is what other classes will subscribe to to get the camera data.
      @Published var current: CVPixelBuffer?
      // 4 Create a queue on which to receive the capture data.
      let videoOutputQueue = DispatchQueue(
        label: "VideoOutputQueue",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem)
      // 5 Set FrameManager as the delegate to AVCaptureVideoDataOutput.
      private override init() {
        super.init()
        CameraManager.shared.set(self, queue: videoOutputQueue)
      }
    
    // In this class, you’re checking if the received CMSampleBuffer contains an image buffer and then sets the current frame. Once again, since current is a published property, it needs to be set on the main thread.
}

// 6 Add the AVCaptureVideoDataOutputSampleBufferDelegate extension to FrameManager.
extension FrameManager: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(
    _ output: AVCaptureOutput,
    didOutput sampleBuffer: CMSampleBuffer,
    from connection: AVCaptureConnection
  ) {
    if let buffer = sampleBuffer.imageBuffer {
      DispatchQueue.main.async {
        self.current = buffer
      }
    }
  }
}
