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
    @State private var selectedItem: String = ""
    
    @State private var selectMulitple: Bool = false
    @Binding var showSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotoThumbnailView(assetLocalId: $selectedItem, isLowQuality: false)
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
                                    selectedItem = asset.localIdentifier
                                } label: {
                                    ZStack {
                                        PhotoThumbnailView(assetLocalId: .constant(asset.localIdentifier), isLowQuality: true)
                                        Color.white.opacity(selectedItem == asset.localIdentifier ? 0.5 : 0)
                                    }
                                }
                            }
                        }
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
                        NewPostDetail()
                    } label: {
                        Text("Next")
                    }
                    .disabled(selectedItem.isEmpty)
                }
            }
        }
        .onAppear() {
            requestForAuthorizationIfNecessary()
        }
    }
}

extension NewPostView {
    func requestForAuthorizationIfNecessary() {
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
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(showSheet: .constant(false))
            .environmentObject(PhotoLibraryService())
    }
}
