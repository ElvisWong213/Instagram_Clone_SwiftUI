//
//  ReelPlayerView.swift
//  InstagramClone
//
//  Created by Elvis on 04/12/2023.
//

import SwiftUI

struct ReelPlayerView: View {
    let color: Color
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        HStack {
                            ProfilePicture(imageLocation: .local(name: "Profile"), size: 40)
                            Text("User name")
                            Button {
                                
                            } label: {
                                Text("Follow")
                            }
                            .buttonStyle(.bordered)
                        }
                        Text("Caption")
                    }
                    Spacer()
                    VStack(spacing: 20) {
                        VStack {
                            Button {
                                
                            } label: {
                                Image(systemName: "heart")
                            }
                            Text("50")
                                .font(.body)
                        }
                        VStack {
                            Button {
                                
                            } label: {
                                Image(systemName: "message")
                            }
                            Text("100")
                                .font(.body)
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                    .font(.title2)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .background(color)
        .foregroundStyle(.white)
    }
}

#Preview {
    ReelPlayerView(color: .black)
}
