//
//  Post.swift
//  InstagramClone
//
//  Created by Elvis on 17/08/2023.
//

import Foundation

struct Post: Codable {
    var likes: [String] = []
    var comments: [Comment] = []
    let date: Date
    let imagesURL: [String]
}

struct Comment: Codable {
    let username: String
    let message: String
}
