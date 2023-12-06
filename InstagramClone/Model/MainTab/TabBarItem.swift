//
//  TabBarItem.swift
//  InstagramClone
//
//  Created by Elvis on 06/12/2023.
//

import Foundation

enum TabBarItem: String, CaseIterable {
    case Home, Search, Add, Reels, Profile

    var description: String {
        switch self {
        case .Home:
            "house"
        case .Search:
            "magnifyingglass"
        case .Add:
            "plus.square"
        case .Reels:
            "video"
        case .Profile:
            "person.crop.circle"
        }
    }    
}
