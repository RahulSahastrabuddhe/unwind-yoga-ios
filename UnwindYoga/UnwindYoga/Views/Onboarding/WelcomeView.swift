//
//  WelcomeView.swift
//  UnwindYoga
//
//  Welcome/Onboarding screen
//

import SwiftUI

struct WelcomeView: View {
    @State private var showLogin = false
    @State private var showTerms = false
    @State private var showPrivacy = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Theme.Colors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Hero Image/Icon
                    Image(systemName: "figure.mind.and.body")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .foregroundColor(Theme.Colors.primary)
                        .padding(.bottom, Theme.Spacing.xl)
                    
                    // Welcome Text
                    VStack(spacing: Theme.Spacing.md) {
                        Text("Welcome to")
                            .font(Theme.Typography.title2)
                            .foregroundColor(Theme.Colors.textSecondary)
                        
                        Text("Unwind Yoga")
                            .font(Theme.Typography.largeTitle)
                            .foregroundColor(Theme.Colors.textPrimary)
                            .fontWeight(.bold)
                    }
                    .padding(.bottom, Theme.Spacing.xxl)
                    
                    Spacer()
                    
                    // Bottom Section
                    VStack(spacing: Theme.Spacing.md) {
                        // Continue Button
                        CustomButton(title: "Continue") {
                            showLogin = true
                        }
                        
                        // Terms and Privacy
                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                Text("By tapping Continue, you agree to our")
                                    .font(Theme.Typography.footnote)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                
                                Button("Terms of Use") {
                                    showTerms = true
                                }
                                .font(Theme.Typography.footnote)
                                .foregroundColor(Theme.Colors.primary)
                            }
                            
                            HStack(spacing: 4) {
                                Text("and")
                                    .font(Theme.Typography.footnote)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                
                                Button("Privacy Policy") {
                                    showPrivacy = true
                                }
                                .font(Theme.Typography.footnote)
                                .foregroundColor(Theme.Colors.primary)
                                
                                Text(". Please review them before continuing.")
                                    .font(Theme.Typography.footnote)
                                    .foregroundColor(Theme.Colors.textSecondary)
                            }
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Theme.Spacing.lg)
                    }
                    .padding(Theme.Spacing.lg)
                    .padding(.bottom, Theme.Spacing.md)
                }
            }
            .navigationDestination(isPresented: $showLogin) {
                LoginView()
            }
            .sheet(isPresented: $showTerms) {
                TermsView()
            }
            .sheet(isPresented: $showPrivacy) {
                PrivacyView()
            }
        }
    }
}

// MARK: - Terms of Use View
struct TermsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    Text("Terms of Use")
                        .font(Theme.Typography.title1)
                        .foregroundColor(Theme.Colors.textPrimary)
                        .padding(.bottom, Theme.Spacing.md)
                    
                    Text("Last updated: November 2025")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .padding(.bottom, Theme.Spacing.lg)
                    
                    Group {
                        sectionTitle("1. Acceptance of Terms")
                        sectionText("By accessing and using Unwind Yoga, you accept and agree to be bound by the terms and provision of this agreement.")
                        
                        sectionTitle("2. Use License")
                        sectionText("Permission is granted to temporarily use Unwind Yoga for personal, non-commercial use only.")
                        
                        sectionTitle("3. Disclaimer")
                        sectionText("The materials within Unwind Yoga are provided on an 'as is' basis. Unwind Yoga makes no warranties, expressed or implied.")
                        
                        sectionTitle("4. Health and Safety")
                        sectionText("Always consult with a healthcare professional before beginning any exercise program. Listen to your body and never force any pose.")
                        
                        sectionTitle("5. Limitations")
                        sectionText("In no event shall Unwind Yoga be liable for any damages arising out of the use or inability to use the materials within the app.")
                    }
                }
                .padding(Theme.Spacing.lg)
            }
            .background(Theme.Colors.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Theme.Colors.primary)
                }
            }
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(Theme.Typography.headline)
            .foregroundColor(Theme.Colors.textPrimary)
            .padding(.top, Theme.Spacing.md)
    }
    
    private func sectionText(_ text: String) -> some View {
        Text(text)
            .font(Theme.Typography.body)
            .foregroundColor(Theme.Colors.textSecondary)
            .padding(.top, Theme.Spacing.xs)
    }
}

// MARK: - Privacy Policy View
struct PrivacyView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    Text("Privacy Policy")
                        .font(Theme.Typography.title1)
                        .foregroundColor(Theme.Colors.textPrimary)
                        .padding(.bottom, Theme.Spacing.md)
                    
                    Text("Last updated: November 2025")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .padding(.bottom, Theme.Spacing.lg)
                    
                    Group {
                        sectionTitle("Information We Collect")
                        sectionText("Unwind Yoga stores your practice data locally on your device. We do not collect or transmit personal information to external servers.")
                        
                        sectionTitle("How We Use Your Information")
                        sectionText("Your data is used solely to personalize your yoga experience and track your progress within the app.")
                        
                        sectionTitle("Data Storage")
                        sectionText("All data is stored locally on your device. If you delete the app, all your data will be permanently removed.")
                        
                        sectionTitle("Third-Party Services")
                        sectionText("This app does not use any third-party analytics or tracking services.")
                        
                        sectionTitle("Your Rights")
                        sectionText("You have full control over your data. You can delete your account and all associated data at any time from the app settings.")
                        
                        sectionTitle("Contact Us")
                        sectionText("If you have any questions about this Privacy Policy, please contact us through the app settings.")
                    }
                }
                .padding(Theme.Spacing.lg)
            }
            .background(Theme.Colors.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Theme.Colors.primary)
                }
            }
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(Theme.Typography.headline)
            .foregroundColor(Theme.Colors.textPrimary)
            .padding(.top, Theme.Spacing.md)
    }
    
    private func sectionText(_ text: String) -> some View {
        Text(text)
            .font(Theme.Typography.body)
            .foregroundColor(Theme.Colors.textSecondary)
            .padding(.top, Theme.Spacing.xs)
    }
}

#Preview {
    WelcomeView()
}
