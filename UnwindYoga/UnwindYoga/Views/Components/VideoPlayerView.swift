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
    
    private var player: AVPlayer? {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            print("⚠️ Could not find video: \(videoName).mp4")
            return nil
        }
        return AVPlayer(url: url)
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        controller.videoGravity = .resizeAspect
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if isPlaying {
            uiViewController.player?.play()
        } else {
            uiViewController.player?.pause()
        }
    }
}

// MARK: - Preview
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoName: "mountain_pose", isPlaying: .constant(true))
            .frame(height: 250)
            .previewLayout(.sizeThatFits)
    }
}
