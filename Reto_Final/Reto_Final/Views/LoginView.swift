//
//  ContentView.swift
//  Reto_Final
//
//  Created by JML on 14/12/22.
//

import SwiftUI

 struct LoginView: View {
     @State var isShowingMenuView = false
     
     var body: some View {
         NavigationView {
             ZStack {
                 Color("sophosBC")
                 
                 VStack{
                     VStack {
                         Image("sophos_logo")
                             .resizable(resizingMode: .stretch)
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 240.0, height: 80.0)
                             
                         Text("Ingresa tus datos aquí")
                             .foregroundColor(Color("violet_UI"))

                         Spacer()
                             .frame(height: 5)
                         
                         TextFieldRoundedFrame()
                         SecTextFieldRoundedFrame()
                     }
                     .padding(.horizontal, 55)
                     //.navigationBarTitle("Vista Inicial", displayMode: .inline)
                     
                     Spacer()
                         .frame(maxHeight: 15)
                     
                     VStack {
                         //NavigationLink(destination: Text("MenuView"), isActive: $isShowingMenuView) { EmptyView() }
                         NavigationLink(destination: Text("MenuView").navigationBarBackButtonHidden(true), isActive: $isShowingMenuView) {
                             RoundedRectangle(cornerRadius: 15)
                                 .fill(Color("violet_UI"))
                                 .frame(width: 350, height: 45.0)
                                 .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
                                 .overlay(HStack {
                                     Button("Ingresar") {
                                         print("Button 1 tapped")
                                         self.isShowingMenuView = true
                                     }
                                     .foregroundColor(Color("sophosBC"))
                                 })
                                 .padding(.vertical, 3
                                 )
                         }
                         
                         NavigationLink(destination: Text("MenuView").navigationBarBackButtonHidden(true), isActive: $isShowingMenuView) {
                             RoundedRectangle(cornerRadius: 15)
                             
                                 .fill(Color("sophosBC"))
                                 .frame(width: 350, height: 45.0)
                                 .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("violet_UI"), lineWidth: 2))
                                 .overlay(HStack {
                                     Image(systemName: "touchid")
                                         .foregroundColor(Color("violet_UI"))
                                         .padding(.leading, 15)
                                     Spacer()
                                     
                                     Button("Ingresar con huella") {
                                         print("Button 2 tapped")
                                         self.isShowingMenuView = true
                                     }
                                     .foregroundColor(Color("violet_UI"))
                                     .padding(.trailing, 105)
                                 })
                                 .padding(.vertical, 3)
                         }
                     }
                     .padding(.horizontal, 55)
                 }
             }
             .edgesIgnoringSafeArea(.all)
         }
     }
 }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
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
                    .disableAutocorrection(true)
                    .foregroundColor(Color("violet_UI"))
                    .padding(.horizontal, 5)
            })
            .padding(.vertical, 3)
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
                    .disableAutocorrection(true)
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
            .padding(.vertical, 3)
    }
}
