//
//  ContentVM.swift
//  InstagramClone
//
//  Created by Elvis on 31/08/2023.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class ContentVM: ObservableObject {
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession.sink { userSession in
            self.userSession = userSession
        }
        .store(in: &cancellables)
    }
}
