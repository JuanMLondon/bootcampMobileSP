//
//  SendDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI
import CoreMedia

struct SendDocumentsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SendDocumentsViewModel.shared.self
    @StateObject var pickerViewModel = ImagePickerViewVM.shared.self
    @State var image: UIImage?
    var imageData: UIImage?
    var base64Image: String?
    
    @State private var isImagePHPickerDisplay = false
    @State private var isUIImagePickerDisplay = false
    
    @State private var selectedOption: String?
    var menuItems: [String] = ["Tomar foto", "Cargar foto"]
    var onOptionSelected: ((_ option: String) -> Void)?
    
    @State private var selectedDocType: String?
    var docTypes: [String] = ["C.C.", "C.E.", "Pasaporte", "T.I."]
    var onDocTypeSelected: ((_ option: String) -> Void)?
    
    @State private var selectedCity: String?
    var cities: [String] = ["Bogotá", "Medellín", "México", "Panamá", "Chile", "Estados Unidos"]
    var onCitySelected: ((_ option: String) -> Void)?
    
    @State var email: String?
    @State var isEmailValid : Bool = true
    var eValidator = EmailValidator()
    
    @State var result: Bool?
    @State var alertMessagePresented: Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("sophosBC")
                VStack {
                    CustomMenuBar()
                        .padding(.top, 75)
                        .padding(.horizontal, 20)

                    Menu(content: {
                        Dropdown(options: self.menuItems) { option in
                            self.selectedOption = option
                            self.onOptionSelected?(option)
                            
                            switch self.selectedOption! {
                            case "Tomar foto":
                                //print(selectedOption!)
                                pickerViewModel.source = .camera
                                pickerViewModel.showPhotoPicker()
                            case "Cargar foto":
                                //print(selectedOption!)
                                pickerViewModel.source = .library
                                pickerViewModel.showPhotoPicker()
                                
                            default:
                                break
                            }
                        }
                    }, label: {
                        HStack{
                            if image != nil {
                                Image(uiImage: self.image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 360, height: 200)
                            } else {
                                Image(systemName: "camera")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 65)
                            }
                        }
                        .foregroundColor(Color("black_UI"))
                        .sheet(isPresented: self.$pickerViewModel.showPicker, content: {
                            ImagePicker(sourceType: pickerViewModel.source == .library ? .photoLibrary : .camera, selectedImage: $image/*, presentationMode: */)
                                .ignoresSafeArea()
                        })
                        .alert("Error", isPresented: $pickerViewModel.showCameraAlert, presenting: pickerViewModel.cameraError, actions: { cameraError in
                            cameraError.button
                        }, message: { cameraError in
                            Text(cameraError.message)
                        })
                    })
                    //.frame(minWidth: 80, idealWidth: 80, maxWidth: .infinity, minHeight: 65, idealHeight: 65, maxHeight: 200)
                    .frame(minWidth: 80, maxWidth: .infinity, minHeight: 65, maxHeight: 180)
                    .padding(.horizontal, 35)
                    
                    DropdownList(dropdownLabel: "Tipo de documento", menuItems: docTypes){ option in
                        self.selectedDocType = option
                        self.onDocTypeSelected?(option)
                        if selectedDocType != nil {
                            viewModel.typeId = selectedDocType!
                            //print(self.selectedDocType!)
                        }
                    }
                    .foregroundColor(Color("black_UI"))
                    .frame(height: 40)
                    .padding(.horizontal, 35)
                    .font(.title3)
                    //.id(self.selectedDocType)
                    
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
                            DropdownList(dropdownLabel: "Ciudad/País", menuItems: cities){ option in
                                self.selectedCity = option
                                self.onCitySelected?(option)
                                if selectedCity != nil {
                                    viewModel.city = selectedCity!
                                    print(self.selectedCity!)
                                }
                            }
                            .foregroundColor(Color("black_UI"))
                            .frame(height: 25)
                            .font(.title3)
                            //.id(self.selectedCity)
                            
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
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("fuchsia_Light"))
                            .frame(width: 280, height: 45.0)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("fuchsia_Light"), lineWidth: 1))
                            .overlay(HStack {
                                Button(action: {
                                    sendButtonAction()
                                    self.viewModel.setParameters()
                                    SendDataService.shared.postData(completion: { success in })
                                    self.alertMessagePresented.toggle()
                                }, label: {
                                    Text("Enviar")
                                    /*Image(systemName: "arrow.forward")
                                        .foregroundColor(Color("white"))
                                        .padding(.trailing, 5)*/
                                })
                                .foregroundColor(Color("white"))
                                .font(.title2)
                                .alert(isPresented: self.$alertMessagePresented) {
                                    if self.result != nil && self.result == true {
                                        dismiss()
                                        return Alert(title: Text("Datos enviados"), message: Text("Los datos fueron enviados exitósamente."), dismissButton: .default(Text("Aceptar")))
                                    }
                                    return Alert(title: Text("No se ha realizado el envío"), message: Text("Complete todos los datos."), dismissButton: .default(Text("Intente nuevamente")))
                                }
                            })
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.viewModel.currentViewSelection = MenuViewModel().currentViewSelection
                
                CustomMenuBarVM().previousView = MenuViewModel().currentViewSelection
                print("Current selection state (from SendDocumentsViewVM): \(String(describing: self.$viewModel.currentViewSelection))")
                self.email = self.viewModel.retrieveEmail()
                //print("Current user email (view): \(self.email!)")
                //print("Current user email (viewModel): \(self.viewModel.email)")
            }
            /*.onDisappear() {
                dismiss()
            }*/
        }
    }
    
    func getImage() -> UIImage? {
        if ImagePicker(selectedImage: $image).selectedImage != nil {
            let imageData = ImagePicker(selectedImage: $image).selectedImage
            return imageData
        }
        return nil
    }
    
    func getBase64() -> String? {
        if self.imageData != nil {
            let base64Image = SendDataService.shared.encodeImgBase64(image: self.imageData!)
            return base64Image
        }
        return nil
    }
    
    func sendButtonAction() {
        print("Button was tapped.")
        if self.image != nil {
            let imageData = getImage()!
            let base64 = SendDataService.shared.encodeImgBase64(image: imageData)
            viewModel.encodedDoc = base64
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.viewModel.result = self.viewModel.getResult()
                self.result = self.viewModel.result
                print("Post successful: \(self.result!)")
            })
        }
    }
}

struct SendDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        SendDocumentsView(viewModel: SendDocumentsViewModel())
    }
}
