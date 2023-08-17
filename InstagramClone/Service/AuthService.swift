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
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try uploadData(id: result.user.uid, username: username, email: email)
        } catch {
            print("Sign Up fail: \(error.localizedDescription)")
            throw error
        }
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
            return
        }
        do {
            let doc = try await Firestore.firestore().collection("users").document(userID).getDocument()
            let userdata = try doc.data(as: User.self)
            DispatchQueue.main.async {
                self.currentUser = userdata
            }
        } catch {
            print("Fetch user fail: \(error.localizedDescription)")
        }
    }
    
    func uploadData(id: String, username: String, email: String) throws {
        let user = User(id: id, username: username, email: email)
        try Firestore.firestore().collection("users").document(user.id).setData(from: user)
        self.currentUser = user
    }
}
