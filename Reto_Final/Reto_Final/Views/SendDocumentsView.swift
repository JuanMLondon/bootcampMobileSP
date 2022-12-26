//
//  SendDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct SendDocumentsView: View {
    
    @ObservedObject var viewModel: SendDocumentsViewModel
    
    var body: some View {
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
                                Text("Envío de documentación")
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
}

struct SendDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        SendDocumentsView(viewModel: SendDocumentsViewModel())
    }
}
