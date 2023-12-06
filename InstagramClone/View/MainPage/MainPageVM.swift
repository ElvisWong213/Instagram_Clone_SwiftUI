//
//  MainPageVM.swift
//  InstagramClone
//
//  Created by Elvis on 01/09/2023.
//

import Foundation

class MainPageVM: ObservableObject {
    @Published var MainPageSelection = 1
    @Published var TabBarSelection: TabBarItem = .Home
    @Published var isLock = false
}
