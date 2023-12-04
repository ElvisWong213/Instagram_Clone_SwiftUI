//
//  ProfilePicture.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct ProfilePicture: View {
    var imageLocation: ImageSource?
    @State var size: CGFloat
    
    var body: some View {
        FormatedImage(imageLocation: imageLocation) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
//                .background(.gray)
                .foregroundStyle(.gray)
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
