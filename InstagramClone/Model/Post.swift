//
//  Post.swift
//  InstagramClone
//
//  Created by Elvis on 17/08/2023.
//

import Foundation
import Firebase

struct Post: Codable, Identifiable {
    let id: String
    var likes: [String] = []
    var comments: [Comment] = []
    let date: Timestamp
    let imagesURL: [String]
    var caption: String
    let createrID: String
}

extension Post {
    static var MOCK: [Post] = [
        .init(id: UUID().uuidString, comments: Comment.MOCK, date: Timestamp(), imagesURL: ["Profile", "Profile"], caption: "Test1", createrID: ""),
        .init(id: UUID().uuidString, comments: Comment.MOCK, date: Timestamp(), imagesURL: ["Profile"], caption: "Test2", createrID: "")
    ]
}
