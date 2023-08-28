//
//  User.swift
//  InstagramClone
//
//  Created by Elvis on 16/08/2023.
//

import Foundation

struct User: Identifiable, Codable  {
    let id: String
    var name: String?
    var username: String
    var email: String
    var image: String?
    var pronouns: String?
    var link: String?
    var gender: Gender? = .None
}

extension User {
    static var MOCK: [User] =
    [
        .init(id: UUID().uuidString, username: "A", email: "A", image: "http://127.0.0.1:9199/v0/b/instagram-clone-89bc4.appspot.com/o/IMG_9592.jpeg?alt=media&token=50dfa9c6-f054-4f2a-882e-6ce49ec12f17"),
        .init(id: UUID().uuidString, username: "B", email: "B", image: "Profile"),
        .init(id: UUID().uuidString, username: "C", email: "C", image: "Profile"),
        .init(id: UUID().uuidString, username: "D", email: "D", image: "Profile")
    ]
}
