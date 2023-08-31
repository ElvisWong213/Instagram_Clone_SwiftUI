//
//  PostView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct PostView: View {
    @Binding var postData: Post
    @StateObject var vm = PostVM()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = vm.user {
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
                    TabView(selection: $vm.selectedImage) {
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
                        postData = vm.likePost(postData: postData)
                    } label: {
                        Image(systemName: vm.isLike ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    Button {
                        vm.showComment.toggle()
                    } label: {
                        Image(systemName: "message")
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "arrowshape.turn.up.right")
                    }
                    Spacer()
                    Button {
                        vm.isBookmark.toggle()
                    } label: {
                        Image(systemName: vm.isBookmark ? "bookmark.fill" : "bookmark")
                    }
                }
                .font(.title2)
                .padding(.horizontal)
                VStack(alignment: .leading, spacing: 5) {
                    Button {
                        
                    } label: {
                        Text("\(postData.likes.count) Likes")
                    }
                    Button {
                        
                    } label: {
                        Text("\(user.username)")
                    }
                    Button {
                        vm.showComment.toggle()
                    } label: {
                        Text("\(postData.caption)")
                            .multilineTextAlignment(.leading)
                    }
                    Text("\(postData.date.dateValue())")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                Spacer()
            } else {
                Spacer()
                Text("Unable to load the post")
                Spacer()
            }
        }
        .alert("Unable to like or remove like from the post", isPresented: $vm.showAlert) {}
        .sheet(isPresented: $vm.showComment) {
            CommentsView(post: $postData)
                .presentationDetents([.large, .medium])
                .presentationDragIndicator(.visible)
        }
        .task {
            await vm.initializePost(postData: postData)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(postData: .constant(Post.MOCK[0]))
    }
}
