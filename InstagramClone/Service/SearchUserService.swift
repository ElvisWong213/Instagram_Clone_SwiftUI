//
//  SearchUserService.swift
//  InstagramClone
//
//  Created by Elvis on 25/11/2023.
//

import Foundation
import FirebaseFirestore

class SearchUserService {
    static func searching(username: String) async -> [User] {
        do {
            let result = Firestore.firestore().collection("users").whereField("username", isGreaterThanOrEqualTo: username).whereField("username", isLessThanOrEqualTo: username + "\u{f8ff}")
            return try await result.getDocuments().documents.compactMap{ try $0.data(as: User.self) }
        } catch {
            print("DEBUG - Fetch usernames list fail: \(error)")
            return []
        }
    }
}
