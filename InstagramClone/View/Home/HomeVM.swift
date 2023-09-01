//
//  HomeVM.swift
//  InstagramClone
//
//  Created by Elvis on 30/08/2023.
//

import Foundation

class HomeVM: ObservableObject {
    @Published var posts: [Post]
    @Published var previousSelection: Int
    @Published var showSheet: Bool
    
    let postService: PostService
    let authService = AuthService.shared
    
    init() {
        self.posts = []
        self.previousSelection = 1
        self.showSheet = false
        self.postService = PostService()
    }
    
    @MainActor
    func fetchPost() async {
        posts = await postService.fetchPosts()
    }
}
