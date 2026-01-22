//
//  DailySessionView.swift
//  UnwindYoga
//
//  Daily yoga session with multiple poses in sequence
//

import SwiftUI
import AVKit

struct DailySessionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var progressService = ProgressService()
    @State private var currentPoseIndex = 0
    @State private var isPlaying = true
    @State private var showSessionComplete = false
    @State private var sessionStartTime = Date()
    @State private var totalSessionTime: TimeInterval = 0
    
    // Get 5 unique random poses that have videos, repeating if necessary
    private let sessionPoses: [YogaPose] = {
        let posesWithVideos = YogaPose.samplePoses.filter { $0.videoName != nil }
        guard !posesWithVideos.isEmpty else { return [] }
        
        // Get unique poses
        var uniquePoses = Array(Set(posesWithVideos))  // Remove any duplicates
        var result = [YogaPose]()
        
        // If we have fewer than 5 unique poses, we'll need to repeat some
        if uniquePoses.count < 5 {
            // First add all unique poses
            result.append(contentsOf: uniquePoses)
            
            // Then fill the remaining slots with random poses from the unique set
            let remainingCount = 5 - uniquePoses.count
            for _ in 0..<remainingCount {
                if let randomPose = uniquePoses.randomElement() {
                    result.append(randomPose)
                }
            }
            
            // Shuffle the result to mix the repeated poses
            result.shuffle()
        } else {
            // If we have 5 or more unique poses, just take the first 5
            result = Array(uniquePoses.shuffled().prefix(5))
        }

        #if DEBUG
        print("Selected poses:")
        result.forEach { print("-\($0.name) (video: \($0.videoName ?? "none"))") }
        #endif

        return result
    }()
    
    private var currentPose: YogaPose {
        sessionPoses[currentPoseIndex]
    }
    
    var body: some View {
        ZStack {
            // Background
            Theme.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 16) {
                // Header with pose name
                VStack(spacing: 4) {
                    Text("Daily Session")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    VStack(spacing: 4) {
                        Text(currentPose.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                        
                        Text(currentPose.sanskritName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .italic()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                .padding(.top, 16)
                
                // Video player with auto-progression and smooth transitions
                if let videoName = currentPose.videoName {
                    VideoPlayerView(
                        videoName: videoName,
                        isPlaying: $isPlaying,
                        onVideoEnded: {
                            // Auto-progress to next pose when video ends
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                nextPose()
                            }
                        }
                    )
                    .id("video-\(currentPose.id)")
                    .frame(height: 300)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .onTapGesture {
                        isPlaying.toggle()
                    }
                    .onAppear {
                        // Auto-play when view appears
                        isPlaying = true
                        sessionStartTime = Date()
                    }
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: currentPoseIndex)
                }
                
                // Navigation controls
                HStack(spacing: 20) {
                    Button(action: previousPose) {
                        Image(systemName: "backward.fill")
                            .font(.title2)
                            .frame(width: 50, height: 50)
                            .background(Theme.Colors.primary.opacity(0.1))
                            .foregroundColor(Theme.Colors.primary)
                            .clipShape(Circle())
                    }
                    .disabled(currentPoseIndex == 0)
                    .opacity(currentPoseIndex == 0 ? 0.5 : 1.0)
                    
                    Button(action: { isPlaying.toggle() }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Theme.Colors.primary)
                    }
                    
                    Button(action: nextPose) {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .frame(width: 50, height: 50)
                            .background(Theme.Colors.primary.opacity(0.1))
                            .foregroundColor(Theme.Colors.primary)
                            .clipShape(Circle())
                    }
                    .disabled(currentPoseIndex == sessionPoses.count - 1)
                    .opacity(currentPoseIndex == sessionPoses.count - 1 ? 0.5 : 1.0)
                }
                .padding(.vertical, 16)
                
                // Pose list with scroll
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today's Poses")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 0) {
                            ForEach(0..<sessionPoses.count, id: \.self) { index in
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(index == currentPoseIndex ? Theme.Colors.primary : Color.gray.opacity(0.2))
                                            .frame(width: 30, height: 30)
                                        
                                        Text("\(index + 1)")
                                            .font(.caption.bold())
                                            .foregroundColor(index == currentPoseIndex ? .white : .primary)
                                    }
                                    
                                    Text(sessionPoses[index].name)
                                        .font(.subheadline)
                                        .foregroundColor(index == currentPoseIndex ? Theme.Colors.primary : .primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 8)
                                        .background(
                                            index == currentPoseIndex ? 
                                            Theme.Colors.primary.opacity(0.1) : 
                                            Color.clear
                                        )
                                        .cornerRadius(8)
                                }
                                .padding(.horizontal)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        currentPoseIndex = index
                                        isPlaying = true
                                    }
                                }
                                
                                if index < sessionPoses.count - 1 {
                                    Divider()
                                        .padding(.leading, 54)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)
                .padding(.bottom, 8)
            }
        }
        .navigationBarTitle("Daily Session", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Theme.Colors.primary)
                }
            }
            
            // Removed the play/pause button from navigation bar
        }
        .alert("End Session?", isPresented: $showSessionComplete) {
            Button("Cancel", role: .cancel) {}
            Button("End", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("Are you sure you want to end your session?")
        }
    }
    
    private func nextPose() {
        guard currentPoseIndex < sessionPoses.count - 1 else {
            // Session completed - mark progress
            totalSessionTime = Date().timeIntervalSince(sessionStartTime)
            progressService.markSessionCompleted(duration: totalSessionTime)
            showSessionComplete = true
            return
        }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            currentPoseIndex += 1
        }

        #if DEBUG
        // Log the current pose being played
        print("▶️ Now playing: \(sessionPoses[currentPoseIndex].name) (video: \(sessionPoses[currentPoseIndex].videoName ?? "none"))")
        #endif
    }
    
    private func previousPose() {
        guard currentPoseIndex > 0 else { return }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            currentPoseIndex -= 1
        }

        #if DEBUG
        // Log the current pose being played
        print("⏮ Now playing: \(sessionPoses[currentPoseIndex].name) (video: \(sessionPoses[currentPoseIndex].videoName ?? "none"))")
        #endif
    }
}

// MARK: - Preview
struct DailySessionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DailySessionView()
        }
    }
}
