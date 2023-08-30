//
//  CommentsView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct CommentsView: View {
    @State var showAlert = false
    @State var myComment = ""
    @Binding var post: Post
    
    var body: some View {
        NavigationStack {
            VStack {
                if !post.comments.isEmpty {
                    List {
                        ForEach(post.comments) { comment in
                            SingleCommentView(userID: comment.userID, commentDate: comment.date.dateValue().description, message: comment.message)
                        }
                    }
                    .buttonStyle(.borderless)
                    .listStyle(.plain)
                } else {
                    Spacer()
                    Text("No Comments")
                    Spacer()
                }
                HStack(spacing: 10) {
                    ProfilePicture(imageLocation: .remote(url: URL(string: AuthService().currentUser?.image ?? "")), size: 50)
                    HStack {
                        TextField("comment", text: $myComment)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(.gray, lineWidth: 2)
                            )
                        Button {
                            do {
                                post = try PostService().leaveComment(comment: myComment, post: post)
                                myComment.removeAll()
                            } catch {
                                showAlert = true
                            }
                        } label: {
                            Text("Send")
                        }
                        .disabled(myComment.isEmpty)
                    }
                }
                .padding(.horizontal)
            }
            .alert("Unable to leave comment", isPresented: $showAlert) {

            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrowshape.turn.up.right")
                    }
                }
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(post: .constant(Post.MOCK[0]))
    }
}
