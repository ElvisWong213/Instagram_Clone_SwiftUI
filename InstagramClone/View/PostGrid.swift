//
//  PostGrid.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

struct PostGrid: View {
    let colums = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums) {
                ForEach(0..<10, id: \.self) { item in
                    NavigationLink {
                        PostView(user: User.MOCK[0], postData: Post.MOCK[0])
                    } label: {
                        FormatedImage(imageLocation: .local(name: "Post"))
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

struct PostGrid_Previews: PreviewProvider {
    static var previews: some View {
        PostGrid()
    }
}
