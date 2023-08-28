//
//  PostService.swift
//  InstagramClone
//
//  Created by Elvis on 17/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import Firebase

class PostService{
    let authService = AuthService.shared
    
    func uploadPost(caption: String, image: UIImage) throws {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.ConvertFail
        }
        guard let userId = authService.userSession?.uid else {
            throw UserError.UnableGetUserData
        }
        let timestamp = Timestamp()
        let postRef = Storage.storage().reference().child("\(userId)/\(timestamp).jpg")
        postRef.putData(data) { _, error in
            if error != nil {
                print("Upload Error: \(error?.localizedDescription ?? "")")
                return
            }
            postRef.downloadURL { url, error in
                if error != nil {
                    print("Download Url error: \(error?.localizedDescription ?? "")")
                    return
                } else {
                    let postRef = Firestore.firestore().collection("posts").document()
                    let post = Post(id: postRef.documentID, date: timestamp, imagesURL: [url?.absoluteString ?? ""], caption: caption, createrID: userId)
                    do {
                        try Firestore.firestore().collection("posts").document(postRef.documentID).setData(from: post)
                    } catch {
                        print("Upload data to Firestore fail: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func fetchPosts() async -> [Post] {
        guard let userID = authService.userSession?.uid else {
            return []
//            throw UserError.UnableGetUserData
        }
        var posts: [Post] = []
        do {
            let query: Query = Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("createrID", isEqualTo: userID)
            posts = try await query.getDocuments().documents.compactMap { try $0.data(as: Post.self) }
        } catch {
            print("Fetch user fail: \(error.localizedDescription)")
        }
        return posts
    }
}
