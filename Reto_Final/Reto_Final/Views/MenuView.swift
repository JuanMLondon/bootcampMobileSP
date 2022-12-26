//
//  MenuView.swift
//  Reto_Final
//
//  Created by JML on 15/12/22.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var viewModel: MenuViewModel
    
    var body: some View {
        ZStack{
            Color("sophosBC")
            VStack{
                HStack {
                    Text(viewModel.getLoggedUser().nombre)
                        .fontWeight(.bold)
                        .frame(width: 190)
                        .font(.title)
                        .foregroundColor(Color("violet_UI"))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                        .frame(maxWidth: 300, maxHeight: 40)
                    
                    Button {
                        print("Menu button was tapped")
                    } label: {
                        Image("menu_icon")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40.0, height: 36.0)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 55)
               
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
            }
            .padding(.bottom, 50)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {

        })
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewModel: MenuViewModel())
    }
}

struct menuItemView: View {
    
    let linkedView: String
    let menuTitle: String
    let menuIconName: String
    let colorScheme: String
    let colorFill: String
    let frameColor: String
    let lighterButtonColor: String
    let lighterButtonFill: String
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .fill(Color(colorFill))
            .frame(minHeight: 75.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(frameColor), lineWidth: 2))
            .overlay(HStack {
                
                Image(systemName: menuIconName)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25.0, height: 25.0)
                    .foregroundColor(Color(colorScheme))
                    .padding(.leading, 30)
                    .padding(.bottom, 30)
                
                Text(menuTitle)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(colorScheme))
                    .padding(.leading, 5)
                    .padding(.bottom, 35)
                
                Spacer()
                
                NavButton(linkedView: linkedView, colorScheme: colorScheme, lighterButtonColor: lighterButtonColor, lighterButtonFill: lighterButtonFill)
            })
            .padding(.vertical, 3)
            .padding(.horizontal, 25)
    }
}

struct NavButton: View {
    
    @State var selection: String? = nil
    let linkedView: String
    let colorScheme: String
    let lighterButtonColor: String
    let lighterButtonFill: String
    
    var body: some View {
        
        switch linkedView {
            
        case "SendDocuments":
            NavigationLink(destination: SendDocumentsView(viewModel: SendDocumentsViewModel()).navigationBarBackButtonHidden(false), tag: linkedView, selection: $selection, label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(lighterButtonFill))
                    .frame(width: 110, height: 28.0)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(lighterButtonColor), lineWidth: 1))
                    .overlay(HStack {
                        Button("Ingresar") {
                            print("Button 3 tapped")
                            self.selection = linkedView
                        }
                        .foregroundColor(Color(colorScheme))
                        .padding(.leading, 10)
                        .font(.footnote)
                        
                        Image(systemName: "arrow.forward")
                            .foregroundColor(Color(colorScheme))
                            .padding(.trailing, 5)
                    })
                    .padding(.trailing, 15)
                    .padding(.top, 30)
            })
            
        case "ViewDocuments":
            NavigationLink(destination: ViewDocumentsView(viewModel: ViewDocumentsViewModel()).navigationBarBackButtonHidden(false), tag: linkedView, selection: $selection, label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(lighterButtonFill))
                    .frame(width: 110, height: 28.0)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(lighterButtonColor), lineWidth: 1))
                    .overlay(HStack {
                        Button("Ingresar") {
                            print("Button 3 tapped")
                            self.selection = linkedView
                        }
                        .foregroundColor(Color(colorScheme))
                        .padding(.leading, 10)
                        .font(.footnote)
                        
                        Image(systemName: "arrow.forward")
                            .foregroundColor(Color(colorScheme))
                            .padding(.trailing, 5)
                    })
                    .padding(.trailing, 15)
                    .padding(.top, 30)
            })
            
        case "Offices":
            NavigationLink(destination: OfficesView(viewModel: OfficesViewModel()).navigationBarBackButtonHidden(false), tag: linkedView, selection: $selection, label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(lighterButtonFill))
                    .frame(width: 110, height: 28.0)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(lighterButtonColor), lineWidth: 1))
                    .overlay(HStack {
                        Button("Ingresar") {
                            print("Button 3 tapped")
                            self.selection = linkedView
                        }
                        .foregroundColor(Color(colorScheme))
                        .padding(.leading, 10)
                        .font(.footnote)
                        
                        Image(systemName: "arrow.forward")
                            .foregroundColor(Color(colorScheme))
                            .padding(.trailing, 5)
                    })
                    .padding(.trailing, 15)
                    .padding(.top, 30)
            })
            
        default:
            NavigationLink(destination: MenuView(viewModel: MenuViewModel()).navigationBarBackButtonHidden(false), tag: linkedView, selection: $selection, label: { EmptyView() })
        }
    }
}

