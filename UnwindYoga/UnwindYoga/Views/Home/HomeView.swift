//
//  HomeView.swift
//  UnwindYoga
//
//  Main home screen with daily session
//

import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var authService: AuthService
    @State private var poses = YogaPose.samplePoses
    @State private var sessions: [YogaSession] = []
    @State private var currentTime = Date()
    @State private var showLibrary = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isShowingDailySession = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Theme.Spacing.lg) {
                        // Header
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(greeting)
                                    .font(Theme.Typography.title2)
                                    .foregroundColor(Theme.Colors.textPrimary)
                                
                                if let user = authService.currentUser {
                                    Text(user.name)
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        .padding(.top, Theme.Spacing.md)
                        
                        // Daily Session Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.orange)
                                Text("Daily Yoga Session")
                                    .font(.headline)
                                Spacer()
                                Text("\(YogaPose.samplePoses.filter { $0.difficulty == .beginner }.count) Poses")
                                    .font(.caption)
                                    .padding(6)
                                    .background(Theme.Colors.primary.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            Text("A perfect sequence for beginners to improve flexibility and strength")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            HStack(spacing: 12) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "clock")
                                            .foregroundColor(Theme.Colors.primary)
                                        Text("\(YogaPose.samplePoses.filter { $0.difficulty == .beginner }.reduce(0) { $0 + $1.duration } / 60) min")
                                            .font(.caption)
                                    }
                                    
                                    HStack {
                                        Image(systemName: "figure.walk")
                                            .foregroundColor(Theme.Colors.primary)
                                        Text("Beginner Level")
                                            .font(.caption)
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    isShowingDailySession = true
                                }) {
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .font(.caption)
                                        Text("Start")
                                            .font(.subheadline)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Theme.Colors.primary)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .background(
                                    NavigationLink("", destination: DailySessionView().navigationBarBackButtonHidden(true), isActive: $isShowingDailySession)
                                        .opacity(0)
                                )
                            }
                            .padding(.top, 8)
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Theme.Colors.primary.opacity(0.05), Theme.Colors.primary.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .shadow(
                            color: Theme.Shadow.small.color,
                            radius: Theme.Shadow.small.radius,
                            x: Theme.Shadow.small.x,
                            y: Theme.Shadow.small.y
                        )
                        
                        // Browse More Button
                        Button(action: {
                            showLibrary = true
                        }) {
                            HStack {
                                Text("Browse More Poses")
                                    .font(Theme.Typography.headline)
                                    .foregroundColor(Theme.Colors.textPrimary)
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                                    .foregroundColor(Theme.Colors.primary)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(Theme.CornerRadius.medium)
                            .shadow(
                                color: Theme.Shadow.small.color,
                                radius: Theme.Shadow.small.radius,
                                x: Theme.Shadow.small.x,
                                y: Theme.Shadow.small.y
                            )
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        
                        // Quick Stats (Placeholder for future)
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            Text("Your Progress")
                                .font(Theme.Typography.title3)
                                .foregroundColor(Theme.Colors.textPrimary)
                            
                            HStack(spacing: Theme.Spacing.md) {
                                StatCard(title: "Sessions", value: "0", icon: "figure.yoga")
                                StatCard(title: "Minutes", value: "0", icon: "clock")
                                StatCard(title: "Streak", value: "0", icon: "flame")
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        .padding(.bottom, Theme.Spacing.xl)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showLibrary) {
                LibraryView()
            }
            .onAppear {
                sessions = YogaSession.sampleSessions(poses: poses)
            }
            .onReceive(timer) { _ in
                currentTime = Date()
            }
        }
    }
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: currentTime)
        switch hour {
        case 0..<12:
            return "Good morning!"
        case 12..<17:
            return "Good afternoon!"
        default:
            return "Good evening!"
        }
    }
}

// MARK: - Daily Session Card
struct DailySessionCard: View {
    let session: YogaSession
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background gradient with subtle pattern
            LinearGradient(
                colors: [Theme.Colors.primary.opacity(0.9), Theme.Colors.primary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 200)
            .cornerRadius(Theme.CornerRadius.large)
            .shadow(
                color: Theme.Colors.primary.opacity(0.3),
                radius: 12,
                x: 0,
                y: 6
            )
            
            // Content
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Daily")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text("Session")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // Duration badge
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.caption)
                        Text("\(session.duration) min")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
                }
                
                Spacer()
                
                // Session name
                Text(session.name)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(1)
                
                // Start button
                Button(action: {
                    // Start session
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                            .font(.system(size: 14))
                        Text("Start Practice")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(Theme.Colors.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(Theme.CornerRadius.medium)
                }
            }
            .padding(Theme.Spacing.lg)
        }
        .frame(height: 200)
    }
}

// MARK: - Stat Card
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: Theme.Spacing.sm) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Theme.Colors.primary)
            
            Text(value)
                .font(Theme.Typography.title2)
                .foregroundColor(Theme.Colors.textPrimary)
            
            Text(title)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Theme.Spacing.lg)
        .background(Color.white)
        .cornerRadius(Theme.CornerRadius.medium)
        .shadow(
            color: Theme.Shadow.small.color,
            radius: Theme.Shadow.small.radius,
            x: Theme.Shadow.small.x,
            y: Theme.Shadow.small.y
        )
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthService())
}
