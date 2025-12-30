//
//  PoseDetailView.swift
//  UnwindYoga
//
//  Detailed view for a single yoga pose with video demonstration
//

import SwiftUI
import AVKit

struct PoseDetailView: View {
    let pose: YogaPose
    @State private var isPlaying = false
    @State private var showVideoPlayer = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Video Player Section
                if let videoName = pose.videoName, !videoName.isEmpty {
                    VStack(spacing: 8) {
                        // Video Player
                        VideoPlayerView(videoName: videoName, isPlaying: $isPlaying)
                            .frame(height: 250)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .onTapGesture {
                                showVideoPlayer = true
                            }
                        
                        // Video Controls
                        HStack {
                            Button(action: togglePlayPause) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(Theme.Colors.primary)
                            }
                            
                            Spacer()
                            
                            Button(action: { showVideoPlayer = true }) {
                                HStack {
                                    Text("Full Screen")
                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                                }
                                .font(.subheadline)
                                .padding(8)
                                .background(Theme.Colors.primary.opacity(0.1))
                                .foregroundColor(Theme.Colors.primary)
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .sheet(isPresented: $showVideoPlayer) {
                        NavigationView {
                            VideoPlayerFullScreenView(videoName: videoName)
                                .navigationBarItems(trailing: Button("Done") {
                                    showVideoPlayer = false
                                })
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Pose Information
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Difficulty
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(pose.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(pose.sanskritName)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .italic()
                        }
                        
                        Spacer()
                        
                        // Difficulty Indicator
                        VStack(alignment: .trailing) {
                            Text(pose.difficulty.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(pose.difficulty.color.opacity(0.2))
                                .foregroundColor(pose.difficulty.color)
                                .cornerRadius(12)
                            
                            Text("\(pose.duration) sec")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Divider()
                    
                    // Description
                    Text(pose.description)
                        .font(.body)
                        .lineSpacing(4)
                    
                    // Benefits
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Benefits:")
                            .font(.headline)
                            .padding(.top, 4)
                        
                        ForEach(pose.benefits, id: \.self) { benefit in
                            HStack(alignment: .top) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Theme.Colors.primary)
                                    .padding(.top, 2)
                                Text(benefit)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    
                    // Instructions
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to:")
                            .font(.headline)
                            .padding(.top, 4)
                        
                        // Add step-by-step instructions here
                        Text("1. Start in a standing position with feet together and arms at your sides.")
                        Text("2. Ground through your feet and engage your thighs.")
                        Text("3. Lengthen through your spine and reach the crown of your head toward the sky.")
                        Text("4. Relax your shoulders away from your ears and extend your fingers toward the floor.")
                        Text("5. Hold for 5-10 breaths, maintaining steady breathing.")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
        .background(Theme.Colors.background)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Add to favorites action
                }) {
                    Image(systemName: "heart")
                }
            }
        }
    }
    
    func togglePlayPause() {
        isPlaying.toggle()
    }
}

// MARK: - Full Screen Video Player
struct VideoPlayerFullScreenView: View {
    let videoName: String
    @State private var isPlaying = true
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Video Player
                VideoPlayerView(videoName: videoName, isPlaying: $isPlaying)
                    .aspectRatio(16/9, contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        // Toggle play/pause when tapping the video
                        isPlaying.toggle()
                    }
                
                // Video Controls
                VStack(spacing: 0) {
                    // Top Bar with Done button
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Text(URL(fileURLWithPath: videoName).deletingPathExtension().lastPathComponent.replacingOccurrences(of: "_", with: " ").capitalized)
                            .font(.headline)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .padding(.trailing, 20)
                        
                        Spacer()
                    }
                    .frame(height: 44)
                    .background(Color.black.opacity(0.7))
                    
                    Spacer()
                    
                    // Playback Controls
                    VStack(spacing: 20) {
                        Spacer()
                        
                        HStack(spacing: 40) {
                            // Play/Pause Button
                            Button(action: { isPlaying.toggle() }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        .onAppear {
            isPlaying = true
        }
        .onDisappear {
            isPlaying = false
        }
    }
}

// MARK: - Difficulty Color Extension
extension YogaPose.Difficulty {
    var color: Color {
        switch self {
        case .beginner: return .green
        case .intermediate: return .orange
        case .advanced: return .red
        }
    }
}

// MARK: - Preview
struct PoseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PoseDetailView(pose: YogaPose.samplePoses[0])
        }
    }
}
