//
//  CommentsView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct CommentsView: View {
    @EnvironmentObject var authService: AuthService
    @State var showAlert = false
    @State var myComment = ""
    @Binding var comments: [Comment]
    let id: String
    
    var body: some View {
        NavigationStack {
            VStack {
                if !comments.isEmpty {
                    List {
                        ForEach(comments, id: \.self) { comment in
                            SingleCommentView(userId: comment.userID, commentDate: comment.date.dateValue().description, message: comment.message)
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
                    ProfilePicture(imageLocation: .remote(url: URL(string: AuthService.shared.currentUser?.image ?? "")), size: 50)
                    HStack {
                        TextField("comment", text: $myComment)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(.gray, lineWidth: 2)
                            )
                        Button {
                            do {
                                comments.append(try PostService.leaveComment(comment: myComment, id: id, isReel: false))
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
            .presentationDetents([.large, .medium])
            .presentationDragIndicator(.visible)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(comments: .constant(Comment.MOCK), id: "")
    }
}
