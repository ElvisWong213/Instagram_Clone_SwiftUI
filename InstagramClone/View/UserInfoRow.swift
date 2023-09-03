//
//  UserInfoRow.swift
//  InstagramClone
//
//  Created by Elvis on 01/09/2023.
//

import SwiftUI

struct UserInfoRow: View {
    @State var user: User
    
    var body: some View {
        HStack {
            ProfilePicture(imageLocation: .remote(url: URL(string: user.image ?? "")), size: 50)
            VStack(alignment: .leading) {
                Text(user.username)
                Text(user.name ?? "")
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            } label: {
                Text("Follow")
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct UserInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoRow(user: User.MOCK[0])
    }
}
