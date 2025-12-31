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
        // First try to find the video in the main bundle
        if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            print("✅ Found video at main bundle: \(url.lastPathComponent)")
            return AVPlayer(url: url)
        }
        
        // If not found, try to find it in the app bundle
        if let resourcePath = Bundle.main.resourcePath {
            let videoPath = "\(resourcePath)/\(videoName).mp4"
            if FileManager.default.fileExists(atPath: videoPath) {
                let url = URL(fileURLWithPath: videoPath)
                print("✅ Found video at: \(url.path)")
                return AVPlayer(url: url)
            }
        }
        
        // Debug: Print available video files
        print("\n⚠️ Could not find video: \(videoName).mp4")
        print("📦 Bundle Identifier: \(Bundle.main.bundleIdentifier ?? "Unknown")")
        print("📁 Bundle Path: \(Bundle.main.bundlePath)")
        
        // List all MP4 files in the main bundle
        if let resourcePath = Bundle.main.resourcePath {
            print("\n📂 Contents of main bundle:")
            let enumerator = FileManager.default.enumerator(atPath: resourcePath)
            var foundVideos = [String]()
            
            while let file = enumerator?.nextObject() as? String {
                if file.lowercased().hasSuffix(".mp4") {
                    foundVideos.append(file)
                }
            }
            
            if foundVideos.isEmpty {
                print("❌ No MP4 files found in the main bundle")
            } else {
                print("✅ Found \(foundVideos.count) video(s):")
                for video in foundVideos.sorted() {
                    print("   - \(video)")
                }
            }
        }
        
        return nil
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        print("\n🔄 Creating video player for: \(videoName).mp4")
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        controller.videoGravity = .resizeAspect
        controller.view.backgroundColor = .clear
        
        // Add observer for playback status
        if let player = controller.player {
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemFailedToPlayToEndTime,
                object: player.currentItem,
                queue: .main
            ) { notification in
                if let error = notification.userInfo?[AVPlayerItemFailedToPlayToEndTimeErrorKey] as? Error {
                    print("❌ Playback failed: \(error.localizedDescription)")
                }
            }
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        print("🔄 Updating video player - isPlaying: \(isPlaying)")
        if isPlaying {
            uiViewController.player?.play()
            print("▶️ Started playing: \(videoName).mp4")
        } else {
            uiViewController.player?.pause()
            print("⏸ Paused: \(videoName).mp4")
        }
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
