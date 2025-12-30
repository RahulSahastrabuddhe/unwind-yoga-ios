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
    @State private var currentPoseIndex = 0
    @State private var timeRemaining = 30
    @State private var isPlaying = true
    @State private var timer: Timer? = nil
    @State private var showSessionComplete = false
    
    // Get 5 random poses that have videos, sorted by difficulty
    private let sessionPoses: [YogaPose] = {
        let posesWithVideos = YogaPose.samplePoses.filter { $0.videoName != nil }
        let shuffled = posesWithVideos.shuffled().prefix(5)
        return Array(shuffled).sorted { $0.duration < $1.duration }
    }()
    
    private var currentPose: YogaPose {
        sessionPoses[currentPoseIndex]
    }
    
    private var progress: Double {
        Double(currentPoseIndex) / Double(sessionPoses.count - 1)
    }
    
    var body: some View {
        ZStack {
            // Background
            Theme.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 4)
                            .opacity(0.3)
                            .foregroundColor(Theme.Colors.primary.opacity(0.3))
                        
                        Rectangle()
                            .frame(width: min(CGFloat(progress) * geometry.size.width, geometry.size.width), height: 4)
                            .foregroundColor(Theme.Colors.primary)
                            .animation(.linear, value: progress)
                    }
                }
                .frame(height: 4)
                
                // Current pose indicator
                HStack {
                    Text("Pose \(currentPoseIndex + 1) of \(sessionPoses.count)")
                        .font(.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                    
                    Spacer()
                    
                    Text(currentPose.difficulty.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(currentPose.difficulty.color.opacity(0.2))
                        .foregroundColor(currentPose.difficulty.color)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Pose name and timer
                VStack(spacing: 8) {
                    Text(currentPose.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text(currentPose.sanskritName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .italic()
                    
                    // Timer
                    Text(timeFormatted(timeRemaining))
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .monospacedDigit()
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(
                            Circle()
                                .stroke(Theme.Colors.primary.opacity(0.2), lineWidth: 10)
                                .frame(width: 180, height: 180)
                        )
                        .padding(.vertical, 20)
                }
                .padding()
                
                // Video player or image
                if let videoName = currentPose.videoName {
                    VideoPlayerView(videoName: videoName, isPlaying: $isPlaying)
                        .frame(height: 220)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .onTapGesture {
                            // Toggle play/pause
                            isPlaying.toggle()
                        }
                } else {
                    Image(currentPose.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                }
                
                // Pose instructions
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("How to:")
                            .font(.headline)
                        
                        // Add step-by-step instructions here
                        Text("1. Start in a comfortable position.")
                        Text("2. Focus on your breath and maintain steady breathing.")
                        Text("3. Hold the pose for the duration shown.")
                        Text("4. Move mindfully to the next pose when prompted.")
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        Text("Benefits:")
                            .font(.headline)
                        
                        ForEach(currentPose.benefits.prefix(3), id: \.self) { benefit in
                            HStack(alignment: .top) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Theme.Colors.primary)
                                    .padding(.top, 2)
                                Text(benefit)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                }
                
                // Navigation buttons
                HStack(spacing: 16) {
                    if currentPoseIndex > 0 {
                        Button(action: previousPose) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Previous")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.Colors.primary.opacity(0.1))
                            .foregroundColor(Theme.Colors.primary)
                            .cornerRadius(10)
                        }
                    }
                    
                    Button(action: nextPose) {
                        HStack {
                            Text(currentPoseIndex == sessionPoses.count - 1 ? "Finish" : "Next")
                            if currentPoseIndex < sessionPoses.count - 1 {
                                Image(systemName: "chevron.right")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.Colors.primary)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Daily Session", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // Confirm before exiting session
                    showSessionComplete = true
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Theme.Colors.primary)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: togglePlayPause) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.title2)
                        .foregroundColor(Theme.Colors.primary)
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .alert("End Session?", isPresented: $showSessionComplete) {
            Button("Continue", role: .cancel) {}
            Button("End Session", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("Are you sure you want to end your session? Your progress will be saved.")
        }
    }
    
    private func startTimer() {
        // Set a default duration of 30 seconds if not specified
        let poseDuration = currentPose.duration > 0 ? currentPose.duration : 30
        timeRemaining = poseDuration
        isPlaying = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 && isPlaying {
                timeRemaining -= 1
            } else if timeRemaining == 0 {
                // Auto-advance to next pose when timer reaches 0
                if currentPoseIndex < sessionPoses.count - 1 {
                    nextPose()
                } else {
                    // Session complete
                    stopTimer()
                    // Show completion message
                    showSessionComplete = true
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func togglePlayPause() {
        isPlaying.toggle()
    }
    
    private func nextPose() {
        if currentPoseIndex < sessionPoses.count - 1 {
            // Pause current video before changing
            isPlaying = false
            
            // Small delay to allow UI to update
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    currentPoseIndex += 1
                    timeRemaining = currentPose.duration
                    // Start playing the next video
                    isPlaying = true
                }
            }
        } else {
            // Session complete
            showSessionComplete = true
        }
    }
    
    private func previousPose() {
        if currentPoseIndex > 0 {
            withAnimation {
                currentPoseIndex -= 1
                timeRemaining = currentPose.duration
            }
        }
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
