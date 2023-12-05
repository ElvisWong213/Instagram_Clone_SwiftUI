//
//  LikeAnimationView.swift
//  InstagramClone
//
//  Created by Elvis on 05/12/2023.
//

import SwiftUI

struct LikeAnimationView: View {
    @State var start: Bool = false
    let position: CGPoint
    
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .foregroundStyle(
                .linearGradient(stops: [.init(color: .orange, location: 0.1), .init(color: .red, location: 0.3), .init(color: Color(cgColor: .init(red: 230 / 255, green: 50 / 255, blue: 134 / 255, alpha: 1)), location: 1)], startPoint: .leading, endPoint: .topTrailing)
            )
            .onAppear() {
                start.toggle()
            }
            .keyframeAnimator(initialValue: AnimationValues(x: position.x, y: position.y), trigger: start) { content, value in
                content
                    .rotationEffect(Angle(degrees: value.degree))
                    .opacity(value.opacity)
                    .scaleEffect(value.scale)
                    .position(x: value.x, y: value.y)
            } keyframes: { _ in
                KeyframeTrack(\.degree) {
                    SpringKeyframe(45, duration: 0.3, spring: .bouncy)
                    SpringKeyframe(-20, duration: 0.5, spring: .bouncy)
                    SpringKeyframe(0, duration: 0.2, spring: .bouncy)
                }
                
                KeyframeTrack(\.opacity) {
                    LinearKeyframe(0.5, duration: 0.25)
                    LinearKeyframe(1, duration: 0.25)
                }
                
                KeyframeTrack(\.scale) {
                    LinearKeyframe(1, duration: 0.5)
                }
                
                KeyframeTrack(\.y) {
                    MoveKeyframe(position.y)
                    LinearKeyframe(position.y, duration: 1)
                    LinearKeyframe(-UIScreen.main.bounds.height, duration: 0.5)
                }
                
                KeyframeTrack(\.x) {
                    MoveKeyframe(position.x)
                    LinearKeyframe(position.x, duration: 1)
                    LinearKeyframe(UIScreen.main.bounds.width / 2, duration: 0.25)
                }
            }
    }
}

struct AnimationValues {
    var degree: Double = 0
    var opacity: Double = 0
    var scale: Double = 0
    var x: Double
    var y: Double
}

#Preview {
    LikeAnimationView(position: CGPoint(x: 200, y: 300))
}
