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

struct Comment: Codable {
    let username: String
    let message: String
}

extension Post {
    static var MOCK: [Post] = [
        .init(id: UUID().uuidString, date: Timestamp(), imagesURL: ["http://127.0.0.1:9199/v0/b/instagram-clone-89bc4.appspot.com/o/DSCF1920.jpeg?alt=media&token=17f960c9-873a-43c6-931e-82179a6e34d1", "http://127.0.0.1:9199/v0/b/instagram-clone-89bc4.appspot.com/o/IMG_9592.jpeg?alt=media&token=50dfa9c6-f054-4f2a-882e-6ce49ec12f17"], caption: "Test1", createrID: "SvhB4qxhifGdTVxsGidRaycOVVqN"),
        .init(id: UUID().uuidString, date: Timestamp(), imagesURL: ["Profile"], caption: "Test2", createrID: "SvhB4qxhifGdTVxsGidRaycOVVqN")
    ]
}
