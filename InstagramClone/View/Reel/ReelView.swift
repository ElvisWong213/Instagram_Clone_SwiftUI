//
//  ReelView.swift
//  InstagramClone
//
//  Created by Elvis on 04/12/2023.
//

import SwiftUI

struct ReelView: View {
    let arr: [Color] = [.yellow, .red, .blue, .green, .yellow, .red, .blue, .green, .yellow, .red, .blue, .green]
    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .top) {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach(arr, id: \.self) { i in
                            ReelPlayerView(color: i)
                                .frame(maxWidth: .infinity)
                                .containerRelativeFrame(.vertical, alignment: .bottom)
                        }
                    }
                }
                .ignoresSafeArea(.container, edges: .vertical)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                HStack {
                    Text("Reel")
                        .font(.title)
                        .bold()
                    Spacer()
                    Image(systemName: "camera")
                        .font(.title2)
                }
                .foregroundStyle(.white)
                .padding()
            }
        }
        .background(.black)
    }
}

#Preview {
    ReelView()
}
