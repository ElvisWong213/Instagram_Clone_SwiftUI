//
//  ProfilePicture.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct ProfilePicture: View {
    @State var imageLocation: ImageSource?
    @State var size: CGFloat
    
    var body: some View {
        ZStack {
            if let imageLocation = imageLocation {
                FormatedImage(imageLocation: imageLocation)
                    .scaledToFit()
            } else {
                Rectangle()
                    .background(.gray)
            }
        }
        .clipShape(Circle())
        .frame(width: size, height: size)
    }
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicture(imageLocation: .local(name: "Profile"), size: 400)
    }
}
