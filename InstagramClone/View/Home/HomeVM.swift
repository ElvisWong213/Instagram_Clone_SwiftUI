//
//  HomeVM.swift
//  InstagramClone
//
//  Created by Elvis on 04/09/2023.
//

import Foundation
import Firebase

class HomeVM: ObservableObject {
    @Published var posts: [Post] = []
    @Published var previousSelection: Int = 1
    
    private let authService: AuthService = AuthService.shared
    
    @MainActor
    func fetchPost() async {
        try? await authService.fetchCurrentUserData()
        var bufferPosts: [Post] = []
        bufferPosts.append(contentsOf: await PostService.fetchCurrentUserPosts())
        guard let following = authService.currentUser?.following else {
            return
        }
        for user in following {
            bufferPosts.append(contentsOf: await PostService.fetchPosts(userId: user))
        }
        bufferPosts.sort { $0.date.dateValue() > $1.date.dateValue() }
        posts = bufferPosts
    }
}
