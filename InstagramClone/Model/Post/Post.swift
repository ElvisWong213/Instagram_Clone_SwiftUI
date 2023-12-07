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
    let media: [PostMedia]
    var caption: String
    let createrID: String
}

extension Post {
    static var MOCK: [Post] = [
        .init(id: UUID().uuidString, comments: Comment.MOCK, date: Timestamp(), media: [PostMedia.MOCK_IMAGE, PostMedia.MOCK_IMAGE2], caption: "Test1", createrID: ""),
        .init(id: UUID().uuidString, comments: Comment.MOCK, date: Timestamp(), media: [PostMedia.MOCK_IMAGE], caption: "Test2", createrID: "")
    ]
}
