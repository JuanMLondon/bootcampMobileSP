//
//  MenuView.swift
//  Reto_Final
//
//  Created by JML on 15/12/22.
//

import SwiftUI

struct MenuView: View {
    
    var userName: String? = "Usuario"
    
    var body: some View {
        ZStack{
            Color("sophosBC")
            VStack{
                HStack {
                    Text("\(userName!)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("violet_UI"))
                        .multilineTextAlignment(.leading)
                    Spacer()
                        .frame(maxWidth: 300, maxHeight: 40)
                    Image("menu_icon")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 40.0, height: 36.0)
                }
                .padding(.horizontal, 25)
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
                
                menuItemView(menuTitle: "Enviar documentos", menuIconName: "doc.text")
                
                menuItemView(menuTitle: "Ver documentos", menuIconName: "doc.text.magnifyingglass")
                
                menuItemView(menuTitle: "Oficinas", menuIconName: "location.magnifyingglass")
                
            }
            .padding(.bottom, 50)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct menuItemView: View {
    
    let menuTitle: String
    let menuIconName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("sophosBC"))
            .frame(minHeight: 75.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                Image(systemName: menuIconName)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25.0, height: 25.0)
                    .foregroundColor(Color("violet_UI"))
                    .padding(.leading, 30)
                    .padding(.bottom, 30)
                
                Text(menuTitle)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("violet_UI"))
                    .padding(.leading, 5)
                    .padding(.bottom, 35)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("sophosBC"))
                    .frame(width: 110, height: 28.0)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("violet_UI"), lineWidth: 1))
                    .overlay(HStack {
                        Button("Ingresar") {
                            print("Button 2 tapped")
                            //self.isShowingMenuView = true
                        }
                        .foregroundColor(Color("violet_UI"))
                        .padding(.leading, 10)
                        .font(.footnote)
                        
                        Image(systemName: "arrow.forward")
                            .foregroundColor(Color("violet_UI"))
                            .padding(.trailing, 5)
                    })
                    .padding(.trailing, 15)
                    .padding(.top, 30)
            })
            .padding(.vertical, 3)
            .padding(.horizontal, 25)
    }
}
