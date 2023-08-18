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

//extension User {
//    static var MOCK: [User] =
//    [
//        .init(id: UUID().uuidString, username: "A", email: "A", image: "Profile"),
//        .init(id: UUID().uuidString, username: "B", email: "B", image: "Profile"),
//        .init(id: UUID().uuidString, username: "C", email: "C", image: "Profile"),
//        .init(id: UUID().uuidString, username: "D", email: "D", image: "Profile")
//    ]
//}
