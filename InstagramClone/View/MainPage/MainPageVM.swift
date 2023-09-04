//
//  MainPageVM.swift
//  InstagramClone
//
//  Created by Elvis on 01/09/2023.
//

import Foundation

class MainPageVM: ObservableObject {
    @Published var MainTabSelection = 1
    @Published var HomeViewSelection = 1
    @Published var isLock = false
}
