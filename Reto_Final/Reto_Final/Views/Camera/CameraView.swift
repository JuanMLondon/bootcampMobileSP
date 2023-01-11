//
//  CameraView.swift
//  Reto_Final
//
//  Created by JML on 8/01/23.
//

import SwiftUI

struct CameraView: View {
    //@ObservedObject private var model = FrameViewModel()
    @StateObject private var model = FrameViewModel()
    
    var body: some View {
        VStack {
            CustomMenuBar()
                .padding(.top, 75)
                .padding(.horizontal, 20)
            //FrameView(image: nil)
            FrameView(image: model.frame)
                .frame(maxWidth: .infinity, minHeight: 500)
                .edgesIgnoringSafeArea(.all)
            ErrorView(error: model.error)
            
            ControlView(
                comicSelected: $model.comicFilter,
                monoSelected: $model.monoFilter,
                crystalSelected: $model.crystalFilter)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
