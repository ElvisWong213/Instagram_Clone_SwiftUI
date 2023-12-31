//
//  PostGrid.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

struct PostGrid: View {
    let colums = Array(repeating: GridItem(.flexible(), spacing: 1), count: 3)
    
    @Binding var posts: [Post]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 1) {
                ForEach($posts) { $post in
                    NavigationLink {
                        PostView(postData: $post)
                    } label: {
                        FormatedImage(imageLocation: .remote(url: URL(string: post.imagesURL[0])))
                            .clipShape(Rectangle())
                            .aspectRatio(1, contentMode: .fill)
                    }
                }
            }
        }
    }
}

struct PostGrid_Previews: PreviewProvider {
    static var previews: some View {
        PostGrid(posts: .constant(Post.MOCK))
    }
}
