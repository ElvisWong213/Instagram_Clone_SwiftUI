//
//  CommentsView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct CommentsView: View {
    @State var myComment = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(0..<6, id: \.self) { index in
                        SingleCommentView()
                    }
                }
                .buttonStyle(.borderless)
                .listStyle(.plain)
                HStack(spacing: 10) {
                    ProfilePicture(imageLocation: ImageSource.local(name: "Profile"), size: 50)
                    TextField("comment", text: $myComment)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(.gray, lineWidth: 2)
                        )
                }
                .padding(.horizontal)
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrowshape.turn.up.right")
                    }
                }
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
