//
//  CustomRoundedButton.swift
//  Reto_Final
//
//  Created by JML on 2/01/23.
//

import SwiftUI

struct CustomRoundedButton: View {
    
    //@ObservedObject var viewModel = SendDocumentsViewModel.sharedSendDocumentsViewVM.self
    
    let buttonText: String?
    let colorScheme: String?
    let lighterButtonColor: String?
    let lighterButtonFill: String?
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(lighterButtonFill!))
            .frame(width: 280, height: 45.0)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(lighterButtonColor!), lineWidth: 1))
            .overlay(HStack {
                Button(buttonText ?? "Button") {
                    performAction()
                }
                .foregroundColor(Color(colorScheme!))
                .font(.title2)
                
                /*Image(systemName: "arrow.forward")
                    .foregroundColor(Color(colorScheme!))
                    .padding(.trailing, 5)*/
            })
    }
    
    func performAction() {
        print("Button was tapped.")
    }
}


struct CustomRoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomRoundedButton(buttonText: "Button", colorScheme: "white_UI", lighterButtonColor: "black_UI", lighterButtonFill: "black_UI")
    }
}

