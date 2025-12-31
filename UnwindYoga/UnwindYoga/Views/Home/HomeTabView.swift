//
//  HomeTabView.swift
//  UnwindYoga
//
//  Home tab content (without tab bar, used inside MainTabView)
//

import SwiftUI
import Combine

struct HomeTabView: View {
    @EnvironmentObject var authService: AuthService
    @State private var poses = YogaPose.samplePoses
    @State private var sessions: [YogaSession] = []
    @State private var currentTime = Date()
    @State private var isShowingDailySession = false
    
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
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        .padding(.top, Theme.Spacing.md)
                        
                        // Daily Session Card with Navigation
                        if let dailySession = sessions.first {
                            NavigationLink(value: "dailySession") {
                                DailySessionCard(session: dailySession)
                                    .padding(.horizontal, Theme.Spacing.lg)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        // Browse More Button
                        NavigationLink(destination: PoseListView()) {
                            HStack {
                                Text("Browse More Poses")
                                    .font(Theme.Typography.headline)
                                    .foregroundColor(Theme.Colors.textPrimary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Theme.Colors.textSecondary)
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
                        .padding(.bottom, Theme.Spacing.xl)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(for: String.self) { value in
                if value == "dailySession" {
                    DailySessionView()
                        .navigationBarBackButtonHidden(true)
                }
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

#Preview {
    HomeTabView()
        .environmentObject(AuthService())
}
