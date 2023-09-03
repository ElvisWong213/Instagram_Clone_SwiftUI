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
import FirebaseStorage

class AuthService: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            do {
                try await fetchLoginUserData()
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
            try await fetchLoginUserData()
        } catch {
            print("DEBUG - Sign In fail: \(error.localizedDescription)")
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
            print("DEBUG - Sign Up fail: \(error.localizedDescription)")
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
            print("DEBUG - Fail to scan username: \(error.localizedDescription)")
            throw error
        }
        return false
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG - Sign Out fail: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchLoginUserData() async throws {
        guard let userId = userSession?.uid else {
            throw UserError.UnableGetUserData
        }
        self.currentUser = try await fetchUserData(userId: userId)
    }
    
    func fetchUserData(userId: String) async throws -> User {
        do {
            if userId == "" {
                throw UserError.UserIdIsEmpty
            }
            let doc = try await Firestore.firestore().collection("users").document(userId).getDocument()
            let userdata = try doc.data(as: User.self)
            return userdata
        } catch {
            print("DEBUG - Fetch user fail: \(error.localizedDescription)")
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
            print("DEBUG - Update user info fail: \(error.localizedDescription)_")
            throw error
        }
    }
    
    func uploadUserProfileImage(image: UIImage) async throws -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.ConvertFail
        }
        guard let userId = AuthService.shared.userSession?.uid else {
            throw UserError.UnableGetUserData
        }
        let imageRef = Storage.storage().reference().child("\(userId)/profileImage.jpg")
        do {
            let _ = try await imageRef.putDataAsync(data)
            let url = try await imageRef.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG - Upload Error: \(error.localizedDescription)")
            return nil
        }
    }
}
