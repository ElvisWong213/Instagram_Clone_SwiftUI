//
//  Gender.swift
//  InstagramClone
//
//  Created by Elvis on 18/08/2023.
//

import Foundation

enum Gender: CaseIterable, Identifiable, CustomStringConvertible, Codable {
    case Male, Female, None
    
    var id: Self { self }
    var description: String {
        switch self {
        case .Male:
            return "Male"
        case .Female:
            return "Female"
        case .None:
            return "None"
        }
    }
    
    enum CodingKeys: CodingKey {
        case Male
        case Female
        case None
    }
}
