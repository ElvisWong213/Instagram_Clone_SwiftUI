//
//  UserError.swift
//  InstagramClone
//
//  Created by Elvis on 18/08/2023.
//

import Foundation

enum UserError: Error, LocalizedError {
    case UnableGetUserData, UsernameUsed, UserIdIsEmpty
    
    var errorDescription: String? {
        switch self {
        case .UnableGetUserData:
            return "Unable to get user data"
        case .UsernameUsed:
            return "Username used"
        case .UserIdIsEmpty:
            return "User id is empty"
        }
    }
}
