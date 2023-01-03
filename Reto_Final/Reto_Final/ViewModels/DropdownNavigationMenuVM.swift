//
//  DropdownNavigationMenuVM.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import SwiftUI

class DropdownNavigationMenuVM: ObservableObject {
    
    static let sharedDropdownNMVM = DropdownNavigationMenuVM()
    
    @ObservedObject var viewModel = MenuViewModel.sharedMenuViewVM.self
    @Published var viewSelection: String?
    @Published var isNavEnabled = false
    @Published var goToView: AnyView?
    
    func navigateAction(linkedView: String, navigateTo: AnyView) {
        self.isNavEnabled = true
        let view = linkedView
        self.viewSelection = view
        self.goToView = navigateTo
        self.viewModel.currentViewSelection = viewSelection!
        print("Go to view: \(String(describing: viewModel.currentViewSelection))")
    }
}

struct Dropdown: View {
    var options: [String]
    var onOptionSelected: ((_ option: String) -> Void)?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(self.options, id: \.self) { option in
                        DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                        //Divider()
                    }
                }
            }
            .frame(minHeight: CGFloat(options.count) * 30, maxHeight: 250)
            .padding(.vertical, 5)
            .background(RoundedRectangle(cornerRadius: 5).fill(Color("sophosBC")))
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("black_UI"), lineWidth: 1)) // Original
        }
        .opacity(1.0)
        .shadow(radius: 15)
    }
}

struct DropdownRow: View {
    
    var option: String
    var onOptionSelected: ((_ option: String) -> Void)?
    
    var body: some View {
        
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }, label: {
            HStack {
                Spacer()
                Text(self.option)
                    .font(.callout)
                    .foregroundColor(Color("black_UI"))
                    .multilineTextAlignment(.center)
            }
            
        })
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}
