//
//  FollowState.swift
//  InstagramClone
//
//  Created by Elvis on 04/09/2023.
//

import Foundation

enum FollowState {
    case following, notFollowing, cannotFollow
    
    var tag: String {
        switch self {
        case .following:
            return "Following"
        case .notFollowing:
            return "Follow"
        case .cannotFollow:
            return ""
        }
    }
}
