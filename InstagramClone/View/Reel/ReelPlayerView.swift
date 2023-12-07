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
    @State var showMuteIcon: Bool = false
    @Binding var isMute: Bool
    
    var body: some View {
        ZStack() {
            CustomVideoPlayer(player: $player)
                .onAppear() {
                    player = AVPlayer(url: Bundle.main.url(forResource: "video", withExtension: "mp4")!)
                    player?.isMuted = isMute
                    player?.play()
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
            ReelInformationView(isLike: $isLike)
//            timeLine()
        }
        .overlay(content: {
            ZStack {
                // Muted indicator
                Image(systemName: isMute ? "speaker.slash" : "speaker.wave.3")
                    .padding()
                    .background() {
                        Circle()
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    .opacity(showMuteIcon ? 1 : 0)
                    .animation(.snappy, value: showMuteIcon)
                // Like animation
                ForEach(likeCounter) { like in
                    LikeAnimationView(position: like.position)
                }
            }
        })
        .onDisappear() {
            likeCounter = []
        }
        .onTapGesture(count: 2) { tapPosition in
            isLike = true
            likeCounter.append(.init(position: tapPosition))
        }
        .onTapGesture {
            isMute.toggle()
            player?.isMuted = isMute
            withAnimation {
                showMuteIcon.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showMuteIcon.toggle()
                }
            }
        }
        // View scroll behaviour
        .background() {
            GeometryReader { geo in
                color.preference(key: ViewOffsetKey.self, value: geo.frame(in: .global).minY)
            }
        }
        .onPreferenceChange(ViewOffsetKey.self, perform: { value in
            player?.isMuted = isMute
            let height = UIScreen.main.bounds.height
            if -value < height / 2 && value < height / 2 {
                player?.play()
            } else {
                player?.pause()
                likeCounter = []
            }
        })
        .foregroundStyle(.white)
    }
    
    @ViewBuilder private func timeLine() -> some View {
        VStack {
            Spacer()
            Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ReelPlayerView(color: .black, isMute: .constant(false))
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
