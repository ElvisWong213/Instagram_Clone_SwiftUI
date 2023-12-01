//
//  NewPostDetail.swift
//  InstagramClone
//
//  Created by Elvis on 15/08/2023.
//

import SwiftUI
import Photos

struct NewPostDetail: View {
    private let photoLibraryService = PhotoLibraryService()
    @EnvironmentObject var authService: AuthService
    @Binding var showSheet: Bool

    @State private var caption: String = ""
    @Binding var selectedPhoto: String
    @State private var image: UIImage?
    
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.height / 3)
                } else {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.gray)
                            .aspectRatio(1, contentMode: .fit)
                        ProgressView()
                    }
                    .scaledToFit()
                }
                TextField("Write a caption", text: $caption, axis: .vertical)
                Spacer()
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        uploadPost()
                        if !showAlert {
                            showSheet = false
                        }
                    } label: {
                        Text("Share")
                    }
                    .alert(errorMessage, isPresented: $showAlert) {}
                }
            }
        }
        .task {
            await loadImageAsset()
        }
    }
}

extension NewPostDetail {
    func loadImageAsset(targetSize: CGSize = PHImageManagerMaximumSize) async {
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        options.resizeMode = .fast
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        guard let uiImage = try? await photoLibraryService.fetchImage(byLocalIdentifier: selectedPhoto, targetSize: targetSize, options: options) else {
            image = nil
            return
        }
        image = uiImage
    }
    
    func uploadPost() {
        guard let image = image else {
            return
        }
        do {
            try PostService.uploadPost(caption: caption, image: image)
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
}

struct NewPostDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewPostDetail(showSheet: .constant(true), selectedPhoto: .constant("Post"))
    }
}
