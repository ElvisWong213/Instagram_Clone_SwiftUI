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

class PostService{
    func uploadPost(caption: String, image: UIImage) throws {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.ConvertFail
        }
        guard let userId = AuthService.shared.userSession?.uid else {
            throw UserError.UnableGetUserData
        }
        let timestamp = Timestamp()
        let postRef = Firestore.firestore().collection("posts").document()
        let postImgRef = Storage.storage().reference().child("\(userId)/\(postRef.documentID).jpg")
        postImgRef.putData(data) { _, error in
            if error != nil {
                print("DEBUG - Upload Error: \(error?.localizedDescription ?? "")")
                return
            }
            postImgRef.downloadURL { url, error in
                if error != nil {
                    print("DEBUG - Download Url error: \(error?.localizedDescription ?? "")")
                    return
                } else {
                    let post = Post(id: postRef.documentID, date: timestamp, imagesURL: [url?.absoluteString ?? ""], caption: caption, createrID: userId)
                    do {
                        try Firestore.firestore().collection("posts").document(postRef.documentID).setData(from: post)
                    } catch {
                        print("DEBUG - Upload data to Firestore fail: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func fetchPosts(userId: String) async -> [Post] {
        var posts: [Post] = []
        do {
            let query: Query = Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("createrID", isEqualTo: userId)
            posts = try await query.getDocuments().documents.compactMap { try $0.data(as: Post.self) }
        } catch {
            print("DEBUG - Fetch posts fail: \(error.localizedDescription)")
        }
        return posts
    }
    
    func fetchCurrentUserPosts() async -> [Post] {
        guard let userId = AuthService.shared.userSession?.uid else {
            return []
        }
        return await fetchPosts(userId: userId)
    }
    
    private func constructComment(comment: String) throws -> Comment {
        guard let userID = AuthService.shared.userSession?.uid else {
            print("DEBUG - Fail to construct comment")
            throw UserError.UnableGetUserData
        }
        return Comment(userID: userID, message: comment, date: Timestamp())
    }
    
    func leaveComment(comment: String, post: Post) throws -> Post {
        let newComment = try constructComment(comment: comment)
        var bufferPost = post
        bufferPost.comments.insert(newComment, at: bufferPost.comments.count)
        let bufferNewComment = try Firestore.Encoder().encode(newComment)
        let docRef = Firestore.firestore().collection("posts").document(post.id)
        docRef.updateData(["comments" : FieldValue.arrayUnion([bufferNewComment])]) { error in
            if let error = error {
                print("DEBUG - Unable to update data: \(error)")
            }
        }
        return bufferPost
    }
    
    func leaveLike(post: Post) throws -> Post {
        guard let userID = AuthService.shared.userSession?.uid else {
            throw UserError.UnableGetUserData
        }
        let docRef = Firestore.firestore().collection("posts").document(post.id)
        docRef.updateData(["likes" : FieldValue.arrayUnion([userID])]) { error in
            if let error = error {
                print("DEBUG - Unable to update data: \(error)")
            }
        }
        var bufferPost = post
        bufferPost.likes.insert(userID, at: bufferPost.likes.count)
        return bufferPost
    }
    
    func removeLike(post: Post) throws -> Post {
        guard let userID = AuthService.shared.userSession?.uid else {
            throw UserError.UnableGetUserData
        }
        let docRef = Firestore.firestore().collection("posts").document(post.id)
        docRef.updateData(["likes" : FieldValue.arrayRemove([userID])]) { error in
            if let error = error {
                print("DEBUG - Unable to update data: \(error)")
            }
        }
        var bufferPost = post
        guard let elementIndex = bufferPost.likes.firstIndex(of: userID) else {
            return bufferPost
        }
        bufferPost.likes.remove(at: elementIndex)
        return bufferPost
    }
}
