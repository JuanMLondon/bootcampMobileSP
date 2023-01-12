//
//  ImagePickerView.swift
//  Reto_Final
//
//  Created by JML on 11/01/23.
//

import SwiftUI

struct ImagePickerView: View {
    
    @StateObject var viewModel = ImagePickerViewVM.shared.self
    
    @State var isShowingImagePicker: Bool = false
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.1)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.horizontal, 15)
                Spacer()
            }
        }
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}
