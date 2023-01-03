//
//  CameraManager.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import AVFoundation

// 1 Creating a class that conforms to ObservableObject to make it easier to use with future Combine code.
class CameraManager: ObservableObject {
    
    // 2 Adding an internal enumeration to represent the status of the camera.
    enum Status {
        case unconfigured, configured, unauthorized, failed
    }
    
    // 3 Including a static shared instance of the camera manager to make it easily accessible.
    static let shared = CameraManager()
    
    // 7 Defining an error to represent any camera-related error. You made it a published property so that other objects can subscribe to this stream and handle any errors as necessary.
    @Published var error: CameraError?
    
    // 8 Defining AVCaptureSession, which will coordinate sending the camera images to the appropriate data outputs.
    let session = AVCaptureSession()
    
    // 9 A session queue, which you’ll use to change any of the camera configurations.
    private let sessionQueue = DispatchQueue(label: "SessionQueue")
    
    // 10 The video data output that will connect to AVCaptureSession. You’ll want this stored as a property so you can change the delegate after the session is configured.
    private let videoOutput = AVCaptureVideoDataOutput()
    
    // 11 The current status of the camera.
    private var status = Status.unconfigured
    
    // 4 Turning the camera manager into a singleton by making init private.
    private init() {
        configure()
    }
    
    // 13 Here, you set the published error to whatever error is passed in. You do this on the main thread, because any published properties should be set on the main thread.
    private func set(error: CameraError?) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
    
    // 14 Next, to check for camera permissions, add the following method to CameraManager:
    private func checkPermissions() {
        // 15 You switch on the camera’s authorization status, specifically for video.
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 16 If the returned device status is undetermined, you suspend the session queue and have iOS request permission to use the camera.
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                // 17 If the user denies access, then you set the CameraManager‘s status to .unauthorized and set the error. Regardless of the outcome, you resume the session queue.
                if !authorized {
                    self.status = .unauthorized
                    self.set(error: .deniedAuthorization)
                }
                self.sessionQueue.resume()
            }
            // 18 For the .restricted and .denied statuses, you set the CameraManager‘s status to .unauthorized and set an appropriate error.
        case .restricted:
            status = .unauthorized
            set(error: .restrictedAuthorization)
        case .denied:
            status = .unauthorized
            set(error: .deniedAuthorization)
            // 5 In the case that permission was already given, nothing needs to be done, so you break out of the switch.
        case .authorized:
            break
            // 6 To make Swift happy, you add an unknown default case — just in case Apple adds more cases to AVAuthorizationStatus in the future.
        @unknown default:
            status = .unauthorized
            set(error: .unknownAuthorization)
        }
        // Note: For any app that needs to request camera access, you need to include a usage string in Info.plist. The starter project already included this usage string, which you’ll find under the key Privacy – Camera Usage Description or the raw key NSCameraUsageDescription. If you don’t set this key, then the app will crash as soon as your code tries to access the camera. Fortunately, the message in the debugger is fairly clear and lets you know you forgot to set this string.
        
    }
    
    // 19 Any time you want to change something about an AVCaptureSession configuration, you need to enclose that code between a beginConfiguration and a commitConfiguration.
    private func configureCaptureSession() {
        guard status == .unconfigured else {
            return
        }
        session.beginConfiguration()
        defer {
            session.commitConfiguration()
        }
        // 20 This code gets your capture device. In this app, you’re getting the front camera. If you want the back camera, you can change position. Since AVCaptureDevice.default(_:_:_:) returns an optional, which will be nil if the requested device doesn’t exist, you need to unwrap it. If for some reason it is nil, set the error and return early.
        let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front)
        guard let camera = device else {
            set(error: .cameraUnavailable)
            status = .failed
            return
        }
        
        do {
            // 21 Try to create an AVCaptureDeviceInput based on the camera. Since this call can throw, you wrap the code in a do-catch block.
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            // 22 Add the camera input to AVCaptureSession, if possible. It’s always a good idea to check if it can be added before adding it.
            if session.canAddInput(cameraInput) {
                session.addInput(cameraInput)
            } else {
                // 23 Otherwise, set the error and the status and return early.
                set(error: .cannotAddInput)
                status = .failed
                return
            }
        } catch {
            // 24 If an error was thrown, set the error based on this thrown error to help with debugging and return.
            set(error: .createCaptureInput(error))
            status = .failed
            return
        }
        
        // 25 You check to see if you can add AVCaptureVideoDataOutput to the session before adding it. This pattern is similar to when you added the input.
        if session.canAddOutput(videoOutput) {
          session.addOutput(videoOutput)
          // 26 Then, you set the format type for the video output.
          videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
          // 27 And force the orientation to be in portrait.
          let videoConnection = videoOutput.connection(with: .video)
          videoConnection?.videoOrientation = .portrait
        } else {
          // 28 If something fails, you set the error and status and return.
          set(error: .cannotAddOutput)
          status = .failed
          return
        }
        status = .configured
    }
    
    // 5 Adding a configure() method stub.
    private func configure() {
        // 29 Now, check for permissions, configure the capture session and start it. All of this happens when CameraManager is initialized.
        checkPermissions()
        sessionQueue.async {
          self.configureCaptureSession()
          self.session.startRunning()
        }
    }
    
    // 30 Using this method, your upcoming frame manager will be able to set itself as the delegate that receives that camera data.
    func set(_ delegate: AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue) {
      sessionQueue.async {
        self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
      }
    }
}

