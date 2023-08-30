//
//  SingleCommentView.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI
//import FirebaseFirestoreSwift
import FirebaseFirestore

struct SingleCommentView: View {
    @State var userIcon: ImageSource?
    @State var userName: String?
    var userID: String
    var commentDate: String
    var message: String
    @State var isLike: Bool = false
    
    var body: some View {
        HStack {
            ProfilePicture(imageLocation: userIcon, size: 50)
            VStack(alignment: .leading) {
                HStack {
                    Text(userName ?? "")
                    Text(commentDate)
                        .font(.footnote)
                }
                Text(message)
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
        .task {
            await fetchUserInfo()
        }
    }
}

extension SingleCommentView {
    func fetchUserInfo() async {
        do {
            let doc = try await Firestore.firestore().collection("users").document(userID).getDocument()
            let userdata = try doc.data(as: User.self)
            userIcon = .remote(url: URL(string: userdata.image ?? ""))
            userName = userdata.username
        } catch {
            print("Fetch user fail: \(error.localizedDescription)")
        }
    }
}

struct SingleCommentView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCommentView(userIcon: .local(name: "Profile"), userName: "User Name", userID: "", commentDate: Date().description, message: "Comment")
    }
}
