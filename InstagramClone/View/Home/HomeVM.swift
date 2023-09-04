//
//  HomeVM.swift
//  InstagramClone
//
//  Created by Elvis on 04/09/2023.
//

import Foundation

class HomeVM: ObservableObject {
    @Published var posts: [Post]
    @Published var previousSelection: Int
    
    let postService: PostService
    
    init() {
        self.posts = []
        self.previousSelection = 1
        self.postService = PostService()
    }
    
    @MainActor
    func fetchPost() async {
        posts = await postService.fetchPosts()
    }
}
