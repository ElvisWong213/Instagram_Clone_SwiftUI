//
//  CashedAsyncImage.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

enum ImageSource {
    case local(name: String)
    case remote(url: URL)
}

struct CashedAsyncImage<Content>: View where Content: View {
    private let source: ImageSource
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
        
    init(source: ImageSource, scale: CGFloat = 1.0, transaction: Transaction = Transaction(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.source = source
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        switch source {
        case .local(let name):
            content(.success(Image(name)))
        case .remote(let url):
            if let cached = ImageCache[url] {
                content(.success(cached))
            } else {
                AsyncImage(url: url, scale: scale, transaction: transaction) { phase in
                    cacheAndRender(phase: phase, url: url)
                }
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase, url: URL) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]
    static private let size = 250
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            let keys = cache.keys
            if keys.count > size {
                ImageCache.cache.remove(at: keys.startIndex)
            }
            ImageCache.cache[url] = newValue
        }
    }
}

struct CashedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CashedAsyncImage(source: ImageSource.local(name: "Post")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
            case .failure(let error):
                fatalError(error.localizedDescription)
            @unknown default:
                fatalError()
            }
        }
    }
}
