//
//  ViewDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct ViewDocumentsView: View {
    
    @ObservedObject var viewModel = ViewDocumentsViewModel.sharedViewDocumentsViewVM.self
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("sophosBC")
                    .toolbar {
                        ToolbarItem(placement: .principal, content: {
                            VStack{
                                
                                HStack{
                                    Spacer()
                                    
                                    Button {
                                        print("Menu button was tapped")
                                    } label: {
                                        Image("menu_icon")
                                            .resizable(resizingMode: .stretch)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40.0, height: 36.0)
                                            .padding(.leading, 40)
                                    }
                                }
                                
                                HStack{
                                    Text("Ver documentos")
                                    //navigationBarTitle("Menú", displayMode: .inline)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            .padding(.top, 55)
                        })
                    }
                    .navigationTitle("Title")
                    .onAppear() {
                    }
            }
            .edgesIgnoringSafeArea(.all)
        }
        Text("Ver documentos enviados")
    }
}

struct ViewDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocumentsView(viewModel: ViewDocumentsViewModel())
    }
}
