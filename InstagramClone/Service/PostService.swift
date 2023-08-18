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
    let authService = AuthService.shared
    
    func uploadPost(caption: String, image: UIImage) throws {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        guard let userId = authService.currentUser?.id else {
            return
        }
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-M-YYYY-HHmmss"
        let filename = dateFormatter.string(from: date)
        let postRef = Storage.storage().reference().child("\(userId)/\(filename).jpg")
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
                    let post = Post(date: date, imagesURL: [url?.absoluteString ?? ""])
                    do {
                        try Firestore.firestore().collection("posts").document(userId).setData(from: post)
                    } catch {
                        print("Upload data to Firestore fail: \(error.localizedDescription)")
                    }
                }
            }
        }
        
    }
}
