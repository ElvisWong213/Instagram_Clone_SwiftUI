//
//  MainTabVM.swift
//  InstagramClone
//
//  Created by Elvis on 30/08/2023.
//

import Foundation

class MainTabVM: ObservableObject {
    @Published var previousSelection: TabBarItem = .Home
    @Published var showSheet: Bool = false
    
    let authService = AuthService.shared
}
