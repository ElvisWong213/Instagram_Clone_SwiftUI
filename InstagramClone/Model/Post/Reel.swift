//
//  Reel.swift
//  InstagramClone
//
//  Created by Elvis on 07/12/2023.
//

import Foundation
import Firebase

struct Reel: PostProtocol {
    let id: String
    var likes: [String] = []
    var comments: [Comment] = []
    let date: Timestamp
    let media: PostMedia
    var caption: String
    let createrID: String
    var forwardCount: Int = 0
    
}

extension Reel {
    static var MOCK: [Reel] = [
        .init(id: UUID().uuidString, comments: Comment.MOCK, date: Timestamp(), media: PostMedia.MOCK_VIDEO, caption: "Test1", createrID: "", forwardCount: 10),
        .init(id: UUID().uuidString, comments: Comment.MOCK, date: Timestamp(), media: PostMedia.MOCK_VIDEO, caption: "Test2", createrID: "", forwardCount: 20)
    ]
}
