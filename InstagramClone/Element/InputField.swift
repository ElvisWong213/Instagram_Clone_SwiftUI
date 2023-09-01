//
//  InputField.swift
//  InstagramClone
//
//  Created by Elvis on 16/08/2023.
//

import SwiftUI

struct InputField: View {
    var title: String
    @Binding var input: String
    var isPassword: Bool
    
    var body: some View {
        Group {
            if isPassword {
                SecureField(title, text: $input)
                    .autocorrectionDisabled()
            } else {
                TextField(title, text: $input)
                    .autocorrectionDisabled()
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(5)
    }
}

struct InputFieldf_Previews: PreviewProvider {
    static var previews: some View {
        InputField(title: "Test", input: .constant(""), isPassword: false)
    }
}
