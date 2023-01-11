//
//  MenuView.swift
//  Reto_Final
//
//  Created by JML on 15/12/22.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = MenuViewModel.shared.self
    @State var viewSelection: String?
    
    var body: some View {
        
        NavigationView {
            ZStack{
                Color("sophosBC")
                
                VStack {
                    
                    Spacer()
                        .frame(maxHeight: 40)
                    
                    HStack {
                        Text(self.viewModel.getLoggedUser().nombre)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(width: 180)
                            .font(.title)
                            .foregroundColor(Color("violet_UI"))
                            //.padding(.top, 0)
                            .padding(.leading, 10)
                            .padding(.trailing, 55)
                        
                        Spacer()
                            .frame(minWidth: 70, maxWidth: 350, minHeight: 40)
                            .overlay(content: {
                                VStack{
                                    HStack{
                                        Spacer()
                                        DropdownNavigationMenu()
                                            .frame(width: 40, height: 26)
                                    }
                                }
                            })
                        //.padding(.top, 55)
                            .padding(.leading, 50)
                            .padding(.trailing, 15)
                            //.padding(.bottom, 0)
                        
                    }
                    .padding(.horizontal, 5)
                    .padding(.top, 10)
                    
                    
                    ZStack {
                        Image("sophos_image")
                            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 400.0, height: 260.0)
                        
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Bienvenido")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                
                                Spacer()
                                
                                Text("Estas son las opciones \rque tenemos para ti")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 250, height: 150)
                            
                            Spacer()
                        }
                    }
                    
                    menuItemView(linkedView: "SendDocuments", menuTitle: "Enviar documentos", menuIconName: "doc.text", colorScheme: "fuchsia_UI", colorFill: "fuchsia_Fill", frameColor: "fuchsia_Frame", lighterButtonColor: "fuchsia_Light", lighterButtonFill: "fuchsia_Fill_L")
                    
                    menuItemView(linkedView: "ViewDocuments", menuTitle: "Ver documentos", menuIconName: "doc.text.magnifyingglass", colorScheme: "violet_UI", colorFill: "violet_Fill", frameColor: "violet_Frame", lighterButtonColor: "violet_Light", lighterButtonFill: "violet_Fill_L")
                    
                    menuItemView(linkedView: "Offices", menuTitle: "Oficinas", menuIconName: "location.magnifyingglass", colorScheme: "green_UI", colorFill: "green_Fill", frameColor: "green_Frame", lighterButtonColor: "green_Light", lighterButtonFill: "green_Fill_L")
                    
                Spacer()
                    
                }
                .padding(.bottom, 50)
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                print("Current view selection state: \(String(describing: self.$viewModel.currentViewSelection))")
            })
        }//
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewModel: MenuViewModel())
    }
}

