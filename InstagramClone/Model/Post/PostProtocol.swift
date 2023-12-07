//
//  PostProtocol.swift
//  InstagramClone
//
//  Created by Elvis on 07/12/2023.
//

import Foundation
import Firebase

protocol PostProtocol: Codable, Identifiable {
    var id: String { get }
    var likes: [String] { get set }
    var comments: [Comment] { get set }
    var date: Timestamp { get }
    var caption: String { get set }
    var createrID: String { get }
}
