//
//  SearchTextField.swift
//  InstagramClone
//
//  Created by Elvis on 03/12/2023.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var searchText: String
    @Binding var searchFocused: Bool
    @FocusState var isFocused: Bool
    
    var body: some View {
            HStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .onTapGesture {
                        withAnimation {
                            searchFocused = true
                        }
                    }
                    .focused($isFocused)
                if searchFocused {
                    Button {
                        withAnimation {
                            searchFocused.toggle()
                        }
                        searchText = ""
                        isFocused.toggle()
                    } label: {
                        Text("Cancel")
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut, value: searchFocused)
    }
}

#Preview {
    SearchTextField(searchText: .constant(""), searchFocused: .constant(false))
}
