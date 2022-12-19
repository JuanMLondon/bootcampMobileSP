//
//  SendDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct SendDocumentsView: View {
    
    @ObservedObject var viewModel: SendDocumentsViewModel
    
    var body: some View {
        ZStack {
            Color("sophosBC")
            Text("Prepare a document for submission")
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SendDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        SendDocumentsView(viewModel: SendDocumentsViewModel())
    }
}
