//
//  Chat.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

struct Chat: View {
    @State var userIcon: ImageSource = .local(name: "Profile")
    @State var userName: String = "User Name"
    @State var message: String = "Message"
    
    var body: some View {
        HStack {
            ProfilePicture(imageLocation: userIcon, size: 50)
            VStack(alignment: .leading) {
                Text(userName)
                Text(message)
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "camera")
            }
        }
    }
}

struct SingleChat_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
