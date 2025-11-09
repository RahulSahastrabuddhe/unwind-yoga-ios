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
                            
                            HStack(spacing: Theme.Spacing.md) {
                                Button(action: {}) {
                                    Image(systemName: "bell")
                                        .font(.title3)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                }
                                
                                Button(action: {}) {
                                    Image(systemName: "gearshape")
                                        .font(.title3)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                }
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        .padding(.top, Theme.Spacing.md)
                        
                        // Daily Session Card
                        if let dailySession = sessions.first {
                            DailySessionCard(session: dailySession)
                                .padding(.horizontal, Theme.Spacing.lg)
                        }
                        
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
            // Background gradient
            LinearGradient(
                colors: [Theme.Colors.primary.opacity(0.8), Theme.Colors.primary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 240)
            .cornerRadius(Theme.CornerRadius.large)
            
            // Content
            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    Text("Your Daily")
                        .font(Theme.Typography.title2)
                        .foregroundColor(.white)
                    
                    Text("Session")
                        .font(Theme.Typography.title2)
                        .foregroundColor(.white)
                }
                
                Text("\(session.duration) min")
                    .font(Theme.Typography.title3)
                    .foregroundColor(.white.opacity(0.9))
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // Start session
                    }) {
                        Text("Start")
                            .font(Theme.Typography.headline)
                            .foregroundColor(Theme.Colors.primary)
                            .frame(width: 120, height: 48)
                            .background(Color.white)
                            .cornerRadius(Theme.CornerRadius.medium)
                    }
                }
            }
            .padding(Theme.Spacing.lg)
        }
        .frame(height: 240)
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
