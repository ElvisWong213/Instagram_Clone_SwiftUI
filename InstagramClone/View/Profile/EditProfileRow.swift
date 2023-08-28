//
//  EditProfileRowView.swift
//  InstagramClone
//
//  Created by Elvis on 18/08/2023.
//

import SwiftUI

struct EditProfileRow: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width: 100, alignment: .leading)
            VStack {
                TextField(title, text: $text)
                Divider()
            }
        }
    }
}

struct EditProfileRowView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileRow(title: "Test", text: .constant("Test"))
    }
}
