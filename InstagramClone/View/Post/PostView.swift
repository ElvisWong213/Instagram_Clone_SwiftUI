//
//  PostView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI
import FirebaseFirestore

struct PostView: View {
    @State var user: User?
    @Binding var postData: Post
    
    @State var selectedImage = 0
    
    @State var isLike = false
    @State var isBookmark = false
    @State var showComment = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = user {
                HStack {
                    ProfilePicture(imageLocation: .remote(url: URL(string: user.image ?? "")), size: 30)
                    Text("\(user.username)")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
                .padding(.horizontal)
                GeometryReader { gr in
                    TabView(selection: $selectedImage) {
                        ForEach(postData.imagesURL.indices, id: \.self) { index in
                            FormatedImage(imageLocation: .remote(url: URL(string: postData.imagesURL[index])))
                                .tag(index)
                        }
                    }
                    .frame(width: gr.size.width, height: gr.size.width)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                }
                .scaledToFit()
                HStack {
                    Button {
                        isLike.toggle()
                    } label: {
                        Image(systemName: isLike ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    Button {
                        showComment.toggle()
                    } label: {
                        Image(systemName: "message")
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "arrowshape.turn.up.right")
                    }
                    Spacer()
                    Button {
                        isBookmark.toggle()
                    } label: {
                        Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
                    }
                }
                .font(.title2)
                .padding(.horizontal)
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(postData.likes.count) Likes")
                    Button {
                        
                    } label: {
                        Text("\(user.username)")
                    }
                    Button {
                        showComment.toggle()
                    } label: {
                        Text("\(postData.caption)")
                            .multilineTextAlignment(.leading)
                    }
                    Text("\(postData.date.dateValue())")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .sheet(isPresented: $showComment) {
            CommentsView(post: $postData)
                .presentationDetents([.large, .medium])
                .presentationDragIndicator(.visible)
        }
        .task {
            await fetchUserData()
        }
    }
}

extension PostView {
    func fetchUserData() async {
        let userID = postData.createrID
        do {
            if user == nil {
            let doc = try await Firestore.firestore().collection("users").document(userID).getDocument()
                user = try doc.data(as: User.self)
            }
        } catch {
            print("Fetch user fail: \(error.localizedDescription)")
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(user: User.MOCK[0], postData: .constant(Post.MOCK[0]))
    }
}
