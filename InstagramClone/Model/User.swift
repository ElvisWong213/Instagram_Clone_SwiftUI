//
//  User.swift
//  InstagramClone
//
//  Created by Elvis on 16/08/2023.
//

import Foundation

struct User: Identifiable, Codable, Hashable  {
    let id: String
    var fullname: String?
    var username: String
    var email: String
    var image: String?
    var pronouns: String?
    var link: String?
    var gender: Gender? = .None
    var followers: [String] = []
    var following: [String] = []
}

extension User {
    static var MOCK: [User] =
    [
        .init(id: UUID().uuidString, fullname: "AAA", username: "A",email: "A", image: ""),
        .init(id: UUID().uuidString, fullname: "BBB", username: "B",email: "B", image: "Profile"),
        .init(id: UUID().uuidString, fullname: "CCC", username: "C",email: "C", image: "Profile"),
        .init(id: UUID().uuidString, fullname: "DDD", username: "D",email: "D", image: "Profile")
    ]
}
