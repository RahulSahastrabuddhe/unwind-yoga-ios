//
//  VideoPlayerView.swift
//  UnwindYoga
//
//  Video player component for yoga pose demonstrations
//

import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable {
    let videoName: String
    @Binding var isPlaying: Bool
    var onVideoEnded: (() -> Void)?
    
    private var player: AVPlayer? {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            print("❌ Could not find video: \(videoName).mp4")
            return nil
        }
        print("✅ Loading video: \(videoName).mp4")
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        return player
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        controller.videoGravity = .resizeAspect
        controller.view.backgroundColor = .clear
        
        // Add observer for when the video ends
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: controller.player?.currentItem,
            queue: .main
        ) { _ in
            onVideoEnded?()
        }
        
        // Add observer for playback failure
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemFailedToPlayToEndTime,
            object: controller.player?.currentItem,
            queue: .main
        ) { notification in
            if let error = notification.userInfo?[AVPlayerItemFailedToPlayToEndTimeErrorKey] as? Error {
                print("❌ Playback failed: \(error.localizedDescription)")
            }
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if isPlaying {
            uiViewController.player?.play()
        } else {
            uiViewController.player?.pause()
        }
    }
    
    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: ()) {
        uiViewController.player?.pause()
        uiViewController.player = nil
    }
}

// MARK: - Preview
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoName: "tree_pose", isPlaying: .constant(true))
            .frame(height: 250)
            .previewLayout(.sizeThatFits)
    }
}
