//
//  CustomMenuBar.swift
//  Reto_Final
//
//  Created by JML on 29/12/22.
//

import SwiftUI

struct CustomMenuBar: View {
    
    @StateObject var viewModel = CustomMenuBarVM.sharedCustomMenuBarVM.self
    
    @State var isNavEnabled = false
    @State var goToView: AnyView?
    @State var previousView: String?
    @State var currentView: String = MenuViewModel.sharedMenuViewVM.currentViewSelection ?? ""
    
    var body: some View {
        
        VStack{
            HStack{
                Button {
                    
                    self.isNavEnabled = viewModel.backButtonAction()
                    
                } label:{
                    HStack{
                        Image(systemName: "arrow.left")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 30, height: 20)
                            .foregroundColor(Color("violet_UI"))
                        Text("Regresar")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("violet_UI"))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.bottom, 10)
                }
                .background(content: {
                    NavigationLink(destination: AnyView(MenuView(viewModel: MenuViewModel())).navigationBarBackButtonHidden(true), isActive: $isNavEnabled, label: { EmptyView() })
                })
                
                Spacer()
                
                Button {
                    print("Menu button was tapped")
                } label: {
                    
                    DropdownNavigationMenu()
                    
                }
            }
            
            HStack{
                Text(viewModel.getTitle(currentView: currentView))
                //Text("Título de la vista")
                //navigationBarTitle("Menú", displayMode: .inline)
                    .foregroundColor(Color("black_UI"))
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.all, 0)
    }
}

struct CustomMenuBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomMenuBar()
    }
}
