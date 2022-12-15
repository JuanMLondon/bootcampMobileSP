//
//  ContentView.swift
//  Reto_Final
//
//  Created by JML on 14/12/22.
//

import SwiftUI

struct LogInView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("sophosBC")
                VStack {
                    Spacer()
                    Image("sophos_logo")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 240.0, height: 80.0)
                        .padding(.top, 10)
                        
                    Text("Ingresa tus datos aquí")
                        .foregroundColor(Color("violet_UI"))
                        .padding(.vertical, 5)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    TextFieldRoundedFrame()
                    
                    SecTextFieldRoundedFrame()
                    
                    Spacer()
                        .frame(height: 10)
                    
                    RoundedRectangleFilledButton()
                    
                    RoundedRectangleButton()
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}


struct TextFieldRoundedFrame: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("sophosBC"))
            .frame(height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(Color("violet_UI"))
                    .padding(.leading, 15)
                
                Divider()
                    .frame(width: 10)
                
                TextField("Email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 5)
            })
            .padding(.vertical, 5)
    }
}

struct SecTextFieldRoundedFrame: View {
    @State var isSecured: Bool = true
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("sophosBC"))
            .frame(height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                Image(systemName: "lock.circle")
                    .foregroundColor(Color("violet_UI"))
                    .padding(.leading, 15)
                
                Divider()
                    .frame(width: 10)
                
                SecureField(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/"Password"/*@END_MENU_TOKEN@*/, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("violet_UI"))
                    .padding(.horizontal, 5)
                
                Button(action: {
                     isSecured.toggle()
                 }) {
                     Image(systemName: self.isSecured ? "eye.slash" : "eye")
                         .foregroundColor(Color("violet_UI"))
                         .padding(.trailing, 15)
                 }
            })
            .padding(.vertical, 5)
    }
}

struct RoundedRectangleFilledButton: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
        
            .fill(Color("violet_UI"))
            .frame(width: 360, height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                Button("Ingresar") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .foregroundColor(Color("sophosBC"))
            })
            .padding(.vertical, 5)
    }
}

struct RoundedRectangleButton: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
        
            .fill(Color("sophosBC"))
            .frame(width: 360, height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
            .overlay(HStack {
                Image(systemName: "touchid")
                    .foregroundColor(Color("violet_UI"))
                    .padding(.leading, 15)
                Spacer()
                
                Button("Ingresar con huella") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .foregroundColor(Color("violet_UI"))
                .padding(.trailing, 105)
            })
            .padding(.vertical, 5)
    }
}
