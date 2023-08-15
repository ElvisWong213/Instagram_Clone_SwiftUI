//
//  PostView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct PostView: View {
    @State var userIcon: ImageSource = .local(name: "Profile")
    @State var userName: String = "User Name"
    
    @State var selectedImage = 1
    @State var numberOfLike = 0
    @State var capation = "Caption fdsjhafdjkshfajhfdsahjfdjsakfhdkasjbfjkdshabfhjdsfhjbfhjadsfjdashfjkdsahfjkadshfjkadshfljkdsahfjdhsafjkdsahfjkals"
    @State var date = "13-8-2023"
    
    @State var isLike = false
    @State var isBookmark = false
    @State var showComment = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ProfilePicture(imageLocation: userIcon, size: 30)
                Text("\(userName)")
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            .padding(.horizontal)
            GeometryReader { gr in
                TabView(selection: $selectedImage) {
                    FormatedImage(imageLocation: .local(name: "Post"))
                        .tag(1)
                    Text("Tab Content 2")
                        .tag(2)
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
                Text("\(numberOfLike) Likes")
                Button {
                    
                } label: {
                    Text("\(userName)")
                }
                Button {
                    showComment.toggle()
                } label: {
                    Text("\(capation)")
                        .multilineTextAlignment(.leading)
                }
                Text("\(date)")
                    .font(.footnote)
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showComment) {
            CommentsView()
                .presentationDetents([.large, .medium])
                .presentationDragIndicator(.visible)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
