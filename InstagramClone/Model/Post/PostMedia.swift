//
//  PostMedia.swift
//  InstagramClone
//
//  Created by Elvis on 07/12/2023.
//

import Foundation

struct PostMedia: Codable {
    let type: MediaType
    let url: String
}

extension PostMedia {
    static let MOCK_IMAGE: PostMedia = .init(type: .Image, url: "Profile")
    static let MOCK_IMAGE2: PostMedia = .init(type: .Image, url: "Profile")
    static let MOCK_VIDEO: PostMedia = .init(type: .Video, url: "")
}
