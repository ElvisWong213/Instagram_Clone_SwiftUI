//
//  ReelInformationView.swift
//  InstagramClone
//
//  Created by Elvis on 06/12/2023.
//

import SwiftUI

struct ReelInformationView: View {
    @Binding var isLike: Bool
    
    var body: some View {
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
                VStack(spacing: 25) {
                    Button {
                        isLike.toggle()
                    } label: {
                        VStack(spacing: 5) {
                            if isLike {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.red)
                            } else {
                                Image(systemName: "heart")
                            }
                            Text("50")
                                .font(.body)
                        }
                    }
                    Button {
                        
                    } label: {
                        VStack(spacing: 5) {
                            Image(systemName: "message")
                            Text("100")
                                .font(.body)
                        }
                    }
                    Button {
                        
                    } label: {
                        VStack(spacing: 5) {
                            Image(systemName: "paperplane")
                            Text("100")
                                .font(.body)
                        }
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
                .font(.title2)
            }
            .padding(.horizontal)
            .padding(.vertical, 30)
            .background() {
                LinearGradient(colors: [.clear, .black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
            }
        }

    }
}

#Preview {
    ReelInformationView(isLike: .constant(false))
}
