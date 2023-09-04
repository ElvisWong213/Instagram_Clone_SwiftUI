//
//  Comment.swift
//  InstagramClone
//
//  Created by Elvis on 28/08/2023.
//

import Foundation
import Firebase

struct Comment: Codable, Hashable {
    let userID: String
    var message: String
    var date: Timestamp
}

extension Comment {
    static var MOCK: [Comment] = [
        .init(userID: UUID().uuidString, message: "Test1", date: Timestamp()),
        .init(userID: UUID().uuidString, message: "Test2", date: Timestamp()),
        .init(userID: UUID().uuidString, message: "Test3", date: Timestamp())
    ]
}
