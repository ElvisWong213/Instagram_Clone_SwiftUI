//
//  TabBarItem.swift
//  InstagramClone
//
//  Created by Elvis on 06/12/2023.
//

import Foundation

enum TabBarItem: String, CaseIterable {
    case Home, Search, Add, Reels, Profile

    var icon: String {
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
    
    var selectedIcon: String {
        switch self {
        case .Home:
            "house.fill"
        case .Search:
            "magnifyingglass"
        case .Add:
            "plus.square.fill"
        case .Reels:
            "video.fill"
        case .Profile:
            "person.crop.circle.fill"
        }
    }
}
