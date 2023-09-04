//
//  MainTabVM.swift
//  InstagramClone
//
//  Created by Elvis on 30/08/2023.
//

import Foundation

class MainTabVM: ObservableObject {
    @Published var previousSelection: Int
    @Published var showSheet: Bool
    
    let authService = AuthService.shared
    
    init() {
        self.previousSelection = 1
        self.showSheet = false
    }
}
