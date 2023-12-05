//
//  ReelPlayerView.swift
//  InstagramClone
//
//  Created by Elvis on 04/12/2023.
//

import SwiftUI
import AVFoundation

struct ReelPlayerView: View {
    let color: Color
    @State var isLike: Bool = false
    @State var player: AVPlayer?
    @State var playTime: CGFloat = .zero
//    @State var isHold: Bool = false
    @State var likeCounter: [Like] = []
    
    var body: some View {
        ZStack() {
            CustomVideoPlayer(player: $player)
                .onAppear() {
                    player = AVPlayer(url: Bundle.main.url(forResource: "video", withExtension: "mp4")!)
                    player?.play()
                    player?.isMuted = true
                }
                .onDisappear() {
                    player?.pause()
                    player = nil
                }
//                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, perform: {
//                }, onPressingChanged: { pressing in
//                    isHold = pressing
//                })
//                .onChange(of: isHold) { oldValue, newValue in
//                    if newValue {
//                        player?.pause()
//                    } else {
//                        player?.play()
//                    }
//                }
            reelInformation()
//            timeLine()
        }
        .overlay(content: {
            ZStack {
                ForEach(likeCounter) { like in
                    LikeAnimationView(position: like.position)
                }
            }
        })
        .onTapGesture(count: 2) { tapPosition in
            isLike = true
            likeCounter.append(.init(position: tapPosition))
        }
//        .onTapGesture {
//            player?.isMuted.toggle()
//        }
        .background() {
            GeometryReader { geo in
                color.preference(key: ViewOffsetKey.self, value: geo.frame(in: .global).minY)
            }
        }
        .onPreferenceChange(ViewOffsetKey.self, perform: { value in
            let height = UIScreen.main.bounds.height
            if -value < height / 2 && value < height / 2 {
                player?.play()
            } else {
                player?.pause()
            }
        })
        .foregroundStyle(.white)
    }
    
    @ViewBuilder private func reelInformation() -> some View {
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
    
    @ViewBuilder private func timeLine() -> some View {
        VStack {
            Spacer()
            Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ReelPlayerView(color: .black)
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct Like: Identifiable {
    let id = UUID()
    let position: CGPoint
}
