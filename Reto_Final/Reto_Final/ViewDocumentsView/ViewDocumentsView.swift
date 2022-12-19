//
//  ViewDocumentsView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct ViewDocumentsView: View {
    
    @ObservedObject var viewModel: ViewDocumentsViewModel
    
    var body: some View {
        ZStack {
            //Color("sophosBC")
            Color.green
            Text("View a list of documents")
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ViewDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocumentsView(viewModel: ViewDocumentsViewModel())
    }
}
