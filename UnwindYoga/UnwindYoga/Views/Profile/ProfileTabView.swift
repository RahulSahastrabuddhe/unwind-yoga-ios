//
//  ProfileTabView.swift
//  UnwindYoga
//
//  Profile tab with user info and settings
//

import SwiftUI

struct ProfileTabView: View {
    @EnvironmentObject var authService: AuthService
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Theme.Spacing.lg) {
                        // Header
                        HStack {
                            Text("Profile")
                                .font(Theme.Typography.title1)
                                .foregroundColor(Theme.Colors.textPrimary)
                            
                            Spacer()
                            
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gearshape")
                                    .font(.title3)
                                    .foregroundColor(Theme.Colors.textPrimary)
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        .padding(.top, Theme.Spacing.lg)
                        
                        // User Profile Card
                        VStack(spacing: Theme.Spacing.md) {
                            // Profile Picture
                            ZStack {
                                Circle()
                                    .fill(Theme.Colors.primary.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(Theme.Colors.primary)
                            }
                            
                            // User Info
                            if let user = authService.currentUser {
                                Text(user.name)
                                    .font(Theme.Typography.title2)
                                    .foregroundColor(Theme.Colors.textPrimary)
                                
                                Text(user.email)
                                    .font(Theme.Typography.body)
                                    .foregroundColor(Theme.Colors.textSecondary)
                            }
                            
                            // Stats Row
                            HStack(spacing: Theme.Spacing.xl) {
                                ProfileStat(value: "24", label: "Sessions")
                                
                                Divider()
                                    .frame(height: 40)
                                
                                ProfileStat(value: "7", label: "Streak")
                                
                                Divider()
                                    .frame(height: 40)
                                
                                ProfileStat(value: "12h", label: "Total Time")
                            }
                            .padding(.top, Theme.Spacing.md)
                        }
                        .padding(.vertical, Theme.Spacing.lg)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(Theme.CornerRadius.large)
                        .padding(.horizontal, Theme.Spacing.lg)
                        
                        // Settings List
                        VStack(spacing: 0) {
                            NavigationLink(destination: AccountSettingsView()) {
                                SettingsRow(icon: "person.circle", title: "Account Settings")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            NavigationLink(destination: NotificationsSettingsView()) {
                                SettingsRow(icon: "bell.badge", title: "Notifications")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            NavigationLink(destination: PrivacySecurityView()) {
                                SettingsRow(icon: "lock.shield", title: "Privacy & Security")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            NavigationLink(destination: HelpSupportView()) {
                                SettingsRow(icon: "questionmark.circle", title: "Help & Support")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            NavigationLink(destination: TermsOfUseView()) {
                                SettingsRow(icon: "doc.text", title: "Terms of Use")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .background(Color.white)
                        .cornerRadius(Theme.CornerRadius.large)
                        .padding(.horizontal, Theme.Spacing.lg)
                        
                        // Logout Button
                        Button(action: {
                            showLogoutAlert = true
                        }) {
                            Text("Logout")
                                .font(Theme.Typography.headline)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(Theme.CornerRadius.medium)
                                .padding(.horizontal, Theme.Spacing.lg)
                                .padding(.vertical, Theme.Spacing.md)
                        }
                        Spacer(minLength: 100) // Extra space for tab bar
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Logout", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Logout", role: .destructive) {
                    authService.logout()
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
        }
    }
}

// MARK: - Profile Stat
struct ProfileStat: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Theme.Colors.textPrimary)
            
            Text(label)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileTabView()
        .environmentObject(AuthService())
}
