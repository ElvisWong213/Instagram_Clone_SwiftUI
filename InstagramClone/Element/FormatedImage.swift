//
//  FormatedImage.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

struct FormatedImage: View {
    private let imageLocation: ImageSource
    
    init(imageLocation: ImageSource) {
        self.imageLocation = imageLocation
    }
    
    var body: some View {
        CashedAsyncImage(source: imageLocation) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure:
                Color.gray
            @unknown default:
                fatalError()
            }
            
        }
    }
}

struct FormatedImage_Previews: PreviewProvider {
    static var previews: some View {
        FormatedImage(imageLocation: .local(name: "Post"))
    }
}
