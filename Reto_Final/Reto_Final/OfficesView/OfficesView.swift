//
//  OfficesView.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import SwiftUI

struct OfficesView: View {
    
    @ObservedObject var viewModel: OfficesViewModel
    
    var body: some View {
        ZStack {
            //Color("sophosBC")
            Color.red
            Text("View the locations on the map")
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct OfficesView_Previews: PreviewProvider {
    static var previews: some View {
        OfficesView(viewModel: OfficesViewModel())
    }
}
