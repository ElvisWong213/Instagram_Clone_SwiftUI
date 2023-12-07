//
//  ReelView.swift
//  InstagramClone
//
//  Created by Elvis on 04/12/2023.
//

import SwiftUI

struct ReelView: View {
    let arr: [Color] = [.yellow, .red, .blue, .green]
    @State var isMute: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(arr, id: \.self) { i in
                            ReelPlayerView(color: i, isMute: $isMute)
                                .id(i)
                                .containerRelativeFrame(.vertical)
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
