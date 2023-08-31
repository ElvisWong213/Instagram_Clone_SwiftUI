//
//  PostGrid.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

struct PostGrid: View {
    @EnvironmentObject var authService: AuthService

    let colums = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State var posts: [Post] = []
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums) {
                ForEach($posts) { $post in
                    NavigationLink {
                        PostView(postData: $post)
                    } label: {
                        FormatedImage(imageLocation: .remote(url: URL(string: post.imagesURL[0])))
                            .scaledToFit()
                    }
                }
            }
        }
        .refreshable {
            posts = await PostService().fetchPosts()
        }
        .task {
            posts = await PostService().fetchPosts()
        }
    }
}

struct PostGrid_Previews: PreviewProvider {
    static var previews: some View {
        PostGrid(posts: Post.MOCK)
            .environmentObject(AuthService())
    }
}
