//
//  AuthService.swift
//  InstagramClone
//
//  Created by Elvis on 16/08/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class AuthService: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            do {
                try await fetchUserData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await fetchUserData()
        } catch {
            print("Sign In fail: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            if try await isUsernameUsed(username: username) {
                throw UserError.UsernameUsed
            }
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try uploadUserData(user: .init(id: result.user.uid, username: username, email: email, image: "", gender: .None))
        } catch {
            print("Sign Up fail: \(error.localizedDescription)")
            throw error
        }
    }
    
    func updateUserPassword(password: String) async throws {
        if password != "" {
            try await Auth.auth().currentUser?.updatePassword(to: password)
        }
    }
    
    func isUsernameUsed(username: String) async throws -> Bool {
        do {
            let doc = try await Firestore.firestore().collection("usernames").document(username).getDocument()
            if doc.exists {
                return true
            }
        } catch {
            print("Fail to scan username: \(error.localizedDescription)")
            throw error
        }
        return false
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.userSession = nil
                self.currentUser = nil
            }
        } catch {
            print("Sign Out fail: \(error.localizedDescription)")
        }
    }
    
    func fetchUserData() async throws {
        guard let userID = userSession?.uid else {
            throw UserError.UnableGetUserData
        }
        do {
            let doc = try await Firestore.firestore().collection("users").document(userID).getDocument()
            let userdata = try doc.data(as: User.self)
            DispatchQueue.main.async {
                self.currentUser = userdata
            }
        } catch {
            print("Fetch user fail: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func uploadUserData(user: User) throws {
        try Firestore.firestore().collection("users").document(user.id).setData(from: user)
        let name = Username(id: user.id)
        try Firestore.firestore().collection("usernames").document(user.username).setData(from: name)
        self.currentUser = user
    }
    
    func updateUserData(user: User) async throws {
        do {
            guard let oldUsername = currentUser?.username else {
                throw UserError.UnableGetUserData
            }
            if try await isUsernameUsed(username: user.username) && oldUsername != user.username {
                throw UserError.UsernameUsed
            }
            try await Firestore.firestore().collection("usernames").document(oldUsername).delete()
            try await uploadUserData(user: user)
        } catch {
            print("Update user info fail: \(error.localizedDescription)_")
            throw error
        }
    }
}
