//
//  SingleCommentView.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

struct SingleCommentView: View {
    @State var userIcon: ImageSource = .local(name: "Profile")
    @State var userName: String = "User Name"
    @State var commentDate: String = "date"
    @State var comment: String = "Comment"
    @State var isLike: Bool = false
    
    var body: some View {
        HStack {
            ProfilePicture(imageLocation: userIcon, size: 50)
            VStack(alignment: .leading) {
                HStack {
                    Text(userName)
                    Text(commentDate)
                        .font(.footnote)
                }
                Text(comment)
                Button {
                    
                } label: {
                    Text("Reply")
                }
            }
            Spacer()
            Button {
                isLike.toggle()
            } label: {
                Image(systemName: isLike ? "heart.fill" : "heart")
            }
        }
    }
}

struct SingleCommentView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCommentView()
    }
}
