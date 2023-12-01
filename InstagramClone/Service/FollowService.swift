//
//  FollowService.swift
//  InstagramClone
//
//  Created by Elvis on 03/09/2023.
//

import Foundation
import FirebaseFirestore

class FollowService {
    static func followingUser(targetId: String) async -> FollowState {
        guard let currentUserId = AuthService.shared.currentUser?.id else {
            print("DEBUG - \(UserError.UnableGetUserData.localizedDescription)")
            return .notFollowing
        }
        let currentUserDocRef = Firestore.firestore().collection("users").document(currentUserId)
        let followUserDocRef = Firestore.firestore().collection("users").document(targetId)
        do {
            try await currentUserDocRef.updateData(["following" : FieldValue.arrayUnion([targetId])])
            try await followUserDocRef.updateData(["followers" : FieldValue.arrayUnion([currentUserId])])
        } catch {
            print("DEBUG - following user fail: \(error.localizedDescription)")
            return .notFollowing
        }
        return .following
    }
    
    static func unfollowingUser(targetId: String) async -> FollowState {
        guard let currentUserId = AuthService.shared.currentUser?.id else {
            print("DEBUG - \(UserError.UnableGetUserData.localizedDescription)")
            return .following
        }
        let currentUserDocRef = Firestore.firestore().collection("users").document(currentUserId)
        let followUserDocRef = Firestore.firestore().collection("users").document(targetId)
        do {
            try await currentUserDocRef.updateData(["following" : FieldValue.arrayRemove([targetId])])
            try await followUserDocRef.updateData(["followers" : FieldValue.arrayRemove([currentUserId])])
        } catch {
            print("DEBUG - unfollowing user fail: \(error.localizedDescription)")
            return .following
        }
        return .notFollowing
    }
    
    static func checkIsFollowing(targetId: String) -> FollowState {
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
