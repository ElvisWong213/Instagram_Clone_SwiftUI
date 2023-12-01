//
//  ProfileVM.swift
//  InstagramClone
//
//  Created by Elvis on 04/09/2023.
//

import Foundation
import SwiftUI

class ProfileVM: ObservableObject {
    let authService = AuthService.shared
    
    @Published var selection = 1
    @Published var showSheet = false
    @Published var user: User?
    @Published var posts: [Post] = []
    
    @MainActor
    func fetchData(userId: String) async {
        user = try? await authService.fetchUserData(userId: userId)
        posts = await PostService.fetchPosts(userId: userId)
    }
    
    func checkIsFollowing(targetId: String) -> FollowState {
        guard let currentUser = AuthService.shared.currentUser else {
            print("DEBUG - No current user")
            return .cannotFollow
        }
        if currentUser.id == targetId {
            return .cannotFollow
        }
        if currentUser.following.contains(targetId) {
            return .following
        }
        return .notFollowing
    }
}
