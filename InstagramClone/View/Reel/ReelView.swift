//
//  ReelView.swift
//  InstagramClone
//
//  Created by Elvis on 04/12/2023.
//

import SwiftUI

struct ReelView: View {
    let arr: [Color] = [.yellow, .red, .blue, .green]
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(arr, id: \.self) { i in
                            ReelPlayerView(color: i)
                                .id(i)
                                .frame(minHeight: geo.size.height)
                                .containerRelativeFrame(.vertical, alignment: .center)
                        }
                    }
                }
                .ignoresSafeArea(.all)
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
                HStack {
                    Text("Reels")
                        .font(.title)
                        .bold()
                    Spacer()
                    Image(systemName: "camera")
                        .font(.title2)
                }
                .foregroundStyle(.white)
                .padding()
            }
            .frame(height: geo.size.height)
        }
        .background(.black)
    }
}

#Preview {
    ReelView()
}
