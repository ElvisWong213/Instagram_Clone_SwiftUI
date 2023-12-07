//
//  NewPostView.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI
import Photos

struct NewPostView: View {
    @EnvironmentObject var photoLibraryService: PhotoLibraryService
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)
    @State private var showError = false
    @State private var selectedPhoto: String = ""
    
    @State private var selectMulitple: Bool = false
    @Binding var showSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotoThumbnailView(assetLocalId: $selectedPhoto, isLowQuality: false)
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            selectMulitple.toggle()
                        } label: {
                            Image(systemName: "rectangle.stack")
                                .padding(10)
                                .foregroundColor(.white)
                                .background(selectMulitple ? .blue : .black)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.trailing)
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(photoLibraryService.results, id: \.self) { asset in
                                Button {
                                    selectedPhoto = asset.localIdentifier
                                } label: {
                                    ZStack {
                                        PhotoThumbnailView(assetLocalId: .constant(asset.localIdentifier), isLowQuality: true)
                                        Color.white.opacity(selectedPhoto == asset.localIdentifier ? 0.5 : 0)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSheet = false
                    } label: {
                        Image(systemName: "multiply")
                    }
                }
                ToolbarItem {
                    NavigationLink {
                        NewPostDetail(showSheet: $showSheet, selectedPhoto: $selectedPhoto)
                    } label: {
                        Text("Next")
                    }
                    .disabled(selectedPhoto.isEmpty)
                }
            }
        }
        .onAppear() {
            requestForAuthorizationIfNecessary()
            selectedFirstImage()
        }
        .alert("This app requires photo library access to show your photos", isPresented: $showError) {}
    }
}

extension NewPostView {
    private func requestForAuthorizationIfNecessary() {
        guard photoLibraryService.authorizationStatus != .authorized else {
            return
        }
        photoLibraryService.requestAuthorization { error in
            guard error != nil else {
                return
            }
            showError = true
        }
    }
    
    private func selectedFirstImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            selectedPhoto = photoLibraryService.results.first?.localIdentifier ?? ""
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(showSheet: .constant(false))
            .environmentObject(PhotoLibraryService())
    }
}
