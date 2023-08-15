//
//  NewPostDetail.swift
//  InstagramClone
//
//  Created by Elvis on 15/08/2023.
//

import SwiftUI

struct NewPostDetail: View {
    @State var caption: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                FormatedImage(imageLocation: .local(name: "Post"))
                    .scaledToFit()
                TextField("Write a caption", text: $caption, axis: .vertical)
                Spacer()
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Text("Share")
                    }
                }
            }
        }
    }
}

struct NewPostDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewPostDetail()
    }
}
