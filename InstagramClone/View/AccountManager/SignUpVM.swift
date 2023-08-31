//
//  SignUpVM.swift
//  InstagramClone
//
//  Created by Elvis on 30/08/2023.
//

import Foundation

class SignUpVM: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    func allFieldEmpty() -> Bool {
        return username.isEmpty || email.isEmpty || password.isEmpty
    }
}
