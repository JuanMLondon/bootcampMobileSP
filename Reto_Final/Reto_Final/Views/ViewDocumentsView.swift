//
//  ViewDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct ViewDocumentsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewDocumentsViewModel.shared.self
    @ObservedObject var getDocumentsService = GetDocumentsService.shared.self
    @ObservedObject var getDataService = GetDataService.shared.self
    
    @State var email: String?
    @State var selectedDoc: String?
    @State var image: UIImage?
    
    @State var isShowingDocumentView = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("sophosBC")
                
                VStack {
                    CustomMenuBar()
                        .padding(.top, 75)
                        .padding(.horizontal, 20)
                    
                    List(getDocumentsService.documentsList, rowContent: { document in
                        
                            Button(action: {
                                self.selectedDoc = document.IdRegistro
                                self.viewModel.setDocID(docID: self.selectedDoc ?? "")
                                print("Selected document ID: \(self.getDataService.docID!)")
                                self.getDataService.fetchData(completion: { success in })
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                                    self.image = self.viewModel.decodeBase64Img(base64String: getDataService.retrievedAttachment!)
                                    self.isShowingDocumentView.toggle()
                                })

                            }, label: {
                                VStack {
                                    HStack {
                                        //Text(document.Fecha!)
                                        Text(document.formattedDate)
                                        Text(" - ")
                                        Text(document.TipoAdjunto!)
                                        Spacer()
                                    }
                                    Spacer()
                                    HStack {
                                        Text(document.Nombre!)
                                        Text(document.Apellido!)
                                        Spacer()
                                    }
                                }
                                .padding(.vertical, 12)
                            })
                            .sheet(isPresented: self.$isShowingDocumentView, content: {
                                DocumentView()
                            })
                    })
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.viewModel.currentViewSelection = MenuViewModel().currentViewSelection
                CustomMenuBarVM().previousView = MenuViewModel().currentViewSelection
                print("Current selection state (from ViewDocumentsViewVM): \(String(describing: self.$viewModel.currentViewSelection))")
                self.email = viewModel.retrieveEmail()
                self.viewModel.setEmail(email: self.email!)
                getDocumentsService.fetchData(completion: { success in })
            }
            /*.onDisappear() {
                dismiss()
            }*/
        }
    }
}

struct ViewDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocumentsView(viewModel: ViewDocumentsViewModel())
    }
}
