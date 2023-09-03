//
//  PhotoThumbnailView.swift
//  InstagramClone
//
//  Created by Elvis on 15/08/2023.
//

import SwiftUI
import Photos

struct PhotoThumbnailView: View {
    @EnvironmentObject var photoLibraryService: PhotoLibraryService
    @State private var image: Image?
    @Binding private var assetLocalId: String
    
    private let options = PHImageRequestOptions()
    
    init(assetLocalId: Binding<String>, isLowQuality: Bool) {
        self._assetLocalId = assetLocalId
        if isLowQuality {
            self.options.deliveryMode = .fastFormat
        } else {
            self.options.deliveryMode = .opportunistic
        }
        self.options.resizeMode = .fast
        self.options.isSynchronous = true
        self.options.isNetworkAccessAllowed = true
    }
    
    var body: some View {
        ZStack {
            if let image = image {
                GeometryReader { gr in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: gr.size.width, height: gr.size.width)
                        .clipped()
                }
                .aspectRatio(1, contentMode: .fit)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .aspectRatio(1, contentMode: .fit)
                ProgressView()
            }
        }
        .onChange(of: assetLocalId, perform: { newValue in
            Task {
                await loadImageAsset()
            }
        })
        .task() {
            await loadImageAsset()
        }
        .onDisappear() {
            image = nil
        }
    }
}

extension PhotoThumbnailView {
    func loadImageAsset(targetSize: CGSize = PHImageManagerMaximumSize) async {
        guard let uiImage = try? await photoLibraryService.fetchImage(byLocalIdentifier: assetLocalId, targetSize: targetSize, options: options) else {
            image = nil
            return
        }
        image = Image(uiImage: uiImage)
    }
}

struct PhotoThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoThumbnailView(assetLocalId: .constant(""), isLowQuality: true)
    }
}
