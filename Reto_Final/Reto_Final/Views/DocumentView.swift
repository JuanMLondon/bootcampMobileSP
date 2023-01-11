//
//  DocumentView.swift
//  Reto_Final
//
//  Created by JML on 7/01/23.
//

import SwiftUI

struct DocumentView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewDocumentsViewModel.shared.self
    @ObservedObject var getDataService = GetDataService.shared.self
    
    @State var isNavEnabled = false
    @State var image: UIImage?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("sophosBC")
                //Color(.systemPink)
                
                VStack {
                    VStack{
                        HStack{
                            Button {
                                ViewDocumentsView().isShowingDocumentView.toggle()
                                self.isNavEnabled.toggle()
                                dismiss()
                                
                            } label:{
                                HStack{
                                    Image(systemName: "arrow.left")
                                        .resizable(resizingMode: .stretch)
                                        .frame(width: 30, height: 20)
                                        .foregroundColor(Color("violet_UI"))
                                    Text("Regresar")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("violet_UI"))
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.bottom, 10)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 25)
                    .padding(.horizontal, 20)
                    
                    if image != nil {
                        Image(uiImage: self.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.image = self.viewModel.decodeBase64Img(base64String: getDataService.retrievedAttachment!)
            }
        }
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView()
    }
}
