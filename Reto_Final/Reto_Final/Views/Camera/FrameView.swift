//
//  FrameView.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import SwiftUI

struct FrameView: View {
    
    @StateObject private var model = FrameViewModel()
    
    var image: CGImage?
    private let label = Text("Camera feed")
    
    var body: some View {
        VStack{
            // 1 Conditionally unwrap the optional image.
            if let image = image {
              // 2 Set up a GeometryReader to access the size of the view. This is necessary to ensure the image is clipped to the screen bounds. Otherwise, UI elements on the screen could potentially be anchored to the bounds of the image instead of the screen.
              GeometryReader { geometry in
                // 3 Create Image from CGImage, scale it to fill the frame and clip it to the bounds. Here, you set the orientation to .upMirrored, because you’ll be using the front camera. If you wanted to use the back camera, this would need to be .up.
                Image(image, scale: 1.0, orientation: .upMirrored, label: label)
                  .resizable()
                  .scaledToFill()
                  .frame(
                    width: geometry.size.width,
                    height: geometry.size.height,
                    alignment: .center)
                  .clipped()
              }
            } else {
              // 4 Return a black view if the image property is nil.
              Color.black
            }
        }//
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
