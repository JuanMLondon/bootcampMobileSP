//
//  SendDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct SendDocumentsView: View {
    
    @StateObject var viewModel = SendDocumentsViewModel.shared.self
    
    //@ObservedObject private var model = FrameViewModel()
    
    @State var viewSelection: String?
    @State var isNavEnabled = false
    @State var goToView: AnyView?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
    @State var base64Image: String?
    @State private var isImagePHPickerDisplay = false
    @State private var isUIImagePickerDisplay = false
    @State private var selectedOption: String?
    
    @State var isEmailValid : Bool = true
    var eValidator = EmailValidator()
    
    var menuItems: [String] = ["Tomar foto", "Cargar foto"]
    var onOptionSelected: ((_ option: String) -> Void)?
    
    var cities: [String] = ["Bogotá", "Medellín", "México", "Panamá", "Chile", "Estados Unidos"]
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("sophosBC")
                VStack {
                    CustomMenuBar()
                        .padding(.top, 75)
                        .padding(.horizontal, 20)
                    
                    if image != nil {
                        Image(uiImage: self.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    } else {
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 65)
                    }
                    
                    Menu(content: {
                        Dropdown(options: self.menuItems) { option in
                            self.selectedOption = option
                            self.onOptionSelected?(option)
                            
                            switch self.selectedOption! {
                                
                            case "Tomar foto":
                                /*
                                print(selectedOption!)
                                self.isNavEnabled.toggle()
                                self.goToView = AnyView(FrameView(image: model.frame))
                                */
                                
                                print(selectedOption!)
                                self.sourceType = .camera
                                self.isUIImagePickerDisplay.toggle()
                                
                                /*
                                print(selectedOption!)
                                self.isNavEnabled.toggle()
                                 */
                                
                            case "Cargar foto":
                                print(selectedOption!)
                                self.sourceType = .photoLibrary
                                self.isImagePHPickerDisplay.toggle()
                                self.image = viewModel.getImage()
                                
                            default:
                                print(self.selectedOption!)
                                break
                            }
                        }
                    }, label: {
                        HStack{
                            Text("Tipo de documento")
                                .font(.title2)
                                .foregroundColor(Color("black_UI"))
                            Spacer()
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 13, height: 8)
                                .foregroundColor(Color("black_UI"))
                        }
                        /*.overlay(content: {
                            NavigationLink(destination: goToView.navigationBarBackButtonHidden(true), isActive: $isNavEnabled, label: { EmptyView() })
                        })*/
                        .sheet(isPresented: self.$isImagePHPickerDisplay, content: {
                            ImagePHPickerModel(selectedImage: self.$image/*, base64SelectedImage: self.$base64Image, sourceType: self.sourceType*/)
                        })
                        .sheet(isPresented: self.$isUIImagePickerDisplay, content: {
                            UIImagePickerModel(selectedImage: self.$image, sourceType: self.sourceType)
                        })
                        /*.sheet(isPresented: self.$isNavEnabled, content: {
                            FrameView(image: model.frame)
                        })*/
                    })
                    .frame(height: 40)
                    .padding(.horizontal, 35)
                    
                    VStack{
                        HStack {
                            Image("badge_icon")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 26, height: 27)
                                .foregroundColor(Color("black_UI"))
                            
                            Spacer()
                            
                            TextField("Número de documento", text: $viewModel.idNumber)
                                .foregroundColor(Color("black_UI"))
                                .frame(height: 20)
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .disableAutocorrection(true)
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        
                        Divider()
                            .overlay(Rectangle().stroke(Color("black_UI"), lineWidth: 0.7))
                        
                        Group {
                            TextField("Nombres", text: $viewModel.name)
                                .foregroundColor(Color("black_UI"))
                                .frame(height: 20)
                                .multilineTextAlignment(.leading)
                                .font(.title3)
                                .disableAutocorrection(true)
                            
                            Divider()
                                .overlay(Rectangle().stroke(Color("black_UI"), lineWidth: 0.7))
                            
                            TextField("Apellidos", text: $viewModel.lastname)
                                .foregroundColor(Color("black_UI"))
                                .frame(height: 20)
                                .multilineTextAlignment(.leading)
                                .font(.title3)
                                .disableAutocorrection(true)
                            
                            Divider()
                                .overlay(Rectangle().stroke(Color("black_UI"), lineWidth: 0.7))
                            
                            TextField("E-mail", text: $viewModel.email, onEditingChanged: { (isChanged) in
                                if !isChanged {
                                    if eValidator.validateEmailString(self.viewModel.email) {
                                        DispatchQueue.main.async {
                                            self.isEmailValid = true
                                        }
                                    } else {
                                        self.isEmailValid = false
                                        self.viewModel.email = ""
                                    }
                                }
                            })
                            .foregroundColor(Color("black_UI"))
                            .frame(height: 20)
                            .multilineTextAlignment(.leading)
                            .font(.title3)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            
                            if !self.isEmailValid {
                                Text("El correo no es válido")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 7)
                            }
                            
                            Divider()
                                .overlay(Rectangle().stroke(Color("black_UI"), lineWidth: 0.7))
                            
                        }

                        Group {
                            DropdownList(dropdownLabel: "Ciudad/País", menuItems: cities)
                                .foregroundColor(Color("black_UI"))
                                .frame(height: 25)
                                .font(.title3)
                            
                            Divider()
                                .overlay(Rectangle().stroke(Color("black_UI"), lineWidth: 0.7))
                            
                            TextField("Tipo de documento", text: $viewModel.doctype)
                                .foregroundColor(Color("black_UI"))
                                .frame(height: 20)
                                .multilineTextAlignment(.leading)
                                .font(.title3)
                                .disableAutocorrection(true)
                            
                            Divider()
                                .overlay(Rectangle().stroke(Color("black_UI"), lineWidth: 0.7))
                        }
                        

                        
                        Spacer()
                            .frame(maxHeight: 80)
                        
                        CustomRoundedButton(buttonText:"Enviar", colorScheme: "white", lighterButtonColor: "fuchsia_Light", lighterButtonFill: "fuchsia_Light")
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 30)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.viewModel.currentViewSelection = MenuViewModel().currentViewSelection
                
                CustomMenuBarVM().previousView = MenuViewModel().currentViewSelection
                //print("Current view selection state (from ViewModel): \(String(describing: self.$viewModel.currentViewSelection))")
            }
        }
    }
}

struct SendDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        SendDocumentsView(viewModel: SendDocumentsViewModel())
    }
}
