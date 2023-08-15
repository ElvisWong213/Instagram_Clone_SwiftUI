//
//  PhotoLibraryService.swift
//  InstagramClone
//
//  Created by Elvis on 15/08/2023.
//

import Foundation
import Photos
import UIKit

enum AuthorizationError: Error {
    case restrictedAccess
}

enum QueryError: Error {
    case phAssetNotFound
}

struct PHFetchResultCollection: RandomAccessCollection, Equatable {

    typealias Element = PHAsset
    typealias Index = Int

    var fetchResult: PHFetchResult<PHAsset>

    var endIndex: Int { fetchResult.count }
    var startIndex: Int { 0 }

    subscript(position: Int) -> PHAsset {
        fetchResult.object(at: fetchResult.count - position - 1)
    }
}

class PhotoLibraryService: ObservableObject {
    var authorizationStatus: PHAuthorizationStatus = .notDetermined
    var imageCachingManager = PHCachingImageManager()
    @Published var results = PHFetchResultCollection(fetchResult: .init())
    
    func requestAuthorization(handleError: ((AuthorizationError?) -> Void)? = nil) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
            self?.authorizationStatus = status
            switch status {
            case .notDetermined, .restricted, .denied:
                handleError?(.restrictedAccess)
            case .authorized, .limited:
                self?.fetchAllPhotos()
            @unknown default:
                break
            }
        }
    }
    
    private func fetchAllPhotos() {
        imageCachingManager.allowsCachingHighQualityImages = false
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeHiddenAssets = false
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        DispatchQueue.main.async {
            self.results.fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        }
    }
    
    func fetchImage(byLocalIdentifier localId: String, targetSize: CGSize = PHImageManagerMaximumSize, contentMode: PHImageContentMode = .default, options: PHImageRequestOptions) async throws -> UIImage? {
        let results = PHAsset.fetchAssets(withLocalIdentifiers: [localId], options: nil)
        guard let asset = results.firstObject else {
            throw QueryError.phAssetNotFound
        }
        
        return try await withCheckedThrowingContinuation({ [weak self] continuation in
            self?.imageCachingManager.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: { image, info in
                if let error = info?[PHImageErrorKey] as? Error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: image)
            })
        })
    }
}
