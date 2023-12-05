//
//  CustomVideoPlayer.swift
//  InstagramClone
//
//  Created by Elvis on 04/12/2023.
//

import Foundation
import AVKit
import SwiftUI

struct CustomVideoPlayer: UIViewControllerRepresentable {
    @Binding var player: AVPlayer?
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayer), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        var parent: CustomVideoPlayer
        
        init(parent: CustomVideoPlayer) {
            self.parent = parent
        }
        
        @objc func restartPlayer() {
            parent.player?.seek(to: .zero)
            parent.player?.play()
        }
    }
    
}
