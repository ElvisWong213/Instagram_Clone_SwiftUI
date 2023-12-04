//
//  FormatedImage.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

struct FormatedImage<Content: View>: View {
    private let imageLocation: ImageSource?
    @ViewBuilder private let placeholder: () -> Content
    
    init(imageLocation: ImageSource?, @ViewBuilder placeholder: @escaping () -> Content =
         {Color.gray}) {
        self.imageLocation = imageLocation
        self.placeholder = placeholder
    }
    
    var body: some View {
        CashedAsyncImage(source: imageLocation) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .renderingMode(.original)
            case .failure:
                placeholder()
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
