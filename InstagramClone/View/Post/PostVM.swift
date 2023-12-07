//
//  PostVM.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import Foundation
import FirebaseFirestore

@MainActor
class PostVM: ObservableObject {
    @Published var user: User?
    @Published var selectedImage: Int
    @Published var isLike: Bool
    @Published var isBookmark: Bool
    @Published var showComment: Bool
    @Published var showAlert: Bool
    
    let postService: PostService = PostService()
    let authService: AuthService = AuthService.shared
    
    init() {
        self.user = nil
        self.selectedImage = 0
        self.isLike = false
        self.isBookmark = false
        self.showComment = false
        self.showAlert = false
    }
    
    private func fetchUserData(postData: Post) async {
        let userID = postData.createrID
        do {
            let doc = try await Firestore.firestore().collection("users").document(userID).getDocument()
            user = try doc.data(as: User.self)
        } catch {
            print("Fetch user fail: \(error.localizedDescription)")
        }
    }
    
    func getPostIsLiked(postData: Post) {
        guard let userId = AuthService.shared.userSession?.uid else {
            print("Unable to get user info")
            return
        }
        if postData.likes.contains(userId) {
            isLike = true
        }
    }
    
    func likePost(postData: inout Post) {
        do {
            if isLike {
                let userId = try PostService.removeLike(id: postData.id, isReel: false)
                postData.likes.removeAll { $0 == userId }
            } else {
                postData.likes.append(try PostService.leaveLike(id: postData.id, isReel: false))
            }
            isLike.toggle()
        } catch {
            showAlert = true
        }
    }
    
    func initializePost(postData: Post) async {
        await fetchUserData(postData: postData)
        getPostIsLiked(postData: postData)
    }
}
