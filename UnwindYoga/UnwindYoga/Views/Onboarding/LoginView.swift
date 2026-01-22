//
//  LoginView.swift
//  UnwindYoga
//
//  Login and Signup screen
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthService
    @StateObject private var oauthService = OAuthService()
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var isSignUpMode = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToHome = false
    @State private var showForgotPassword = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Theme.Colors.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: Theme.Spacing.lg) {
                    // Header
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(Theme.Colors.textPrimary)
                        }
                        .padding(.bottom, Theme.Spacing.md)
                        
                        Text(isSignUpMode ? "Create Account" : "Login to Unwind Yoga")
                            .font(Theme.Typography.title1)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        Text(isSignUpMode ? "Start your wellness journey today" : "Continue your journey to mindfulness and health")
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, Theme.Spacing.xl)
                    
                    // Form
                    VStack(spacing: Theme.Spacing.md) {
                        if isSignUpMode {
                            CustomTextField(
                                placeholder: "Full Name",
                                text: $name,
                                textContentType: .name
                            )
                        }
                        
                        CustomTextField(
                            placeholder: "Email / Username",
                            text: $email,
                            keyboardType: .emailAddress,
                            textContentType: .emailAddress
                        )
                        
                        CustomTextField(
                            placeholder: "Password",
                            text: $password,
                            isSecure: true,
                            textContentType: isSignUpMode ? .newPassword : .password
                        )
                    }
                    .padding(.top, Theme.Spacing.lg)
                    
                    // Action Buttons
                    VStack(spacing: Theme.Spacing.md) {
                        CustomButton(
                            title: isSignUpMode ? "Sign Up" : "Login",
                            action: handleAuth
                        )
                        
                        CustomButton(
                            title: isSignUpMode ? "Already have an account? Login" : "Create New Account",
                            action: { isSignUpMode.toggle() },
                            style: .secondary
                        )
                    }
                    .padding(.top, Theme.Spacing.lg)
                    
                    // Social Login (Placeholder for future)
                    VStack(spacing: Theme.Spacing.md) {
                        HStack {
                            Rectangle()
                                .fill(Theme.Colors.textSecondary.opacity(0.3))
                                .frame(height: 1)
                            
                            Text("OR")
                                .font(Theme.Typography.footnote)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .padding(.horizontal, Theme.Spacing.sm)
                            
                            Rectangle()
                                .fill(Theme.Colors.textSecondary.opacity(0.3))
                                .frame(height: 1)
                        }
                        
                        HStack(spacing: Theme.Spacing.md) {
                            SocialLoginButton(
                                icon: "apple.logo", 
                                action: handleAppleSignIn,
                                isLoading: oauthService.isAuthenticating
                            )
                        }
                    }
                    .padding(.top, Theme.Spacing.lg)
                    
                    // Forgot Password
                    if !isSignUpMode {
                        Button("Forgot Password?") {
                            showForgotPassword = true
                        }
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.primary)
                        .padding(.top, Theme.Spacing.md)
                    }
                    
                    // Guest Mode
                    Button(action: {
                        authService.continueAsGuest()
                        navigateToHome = true
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "person.crop.circle")
                                .font(.body)
                            
                            Text("Continue as Guest")
                                .font(Theme.Typography.body)
                        }
                        .foregroundColor(Theme.Colors.textSecondary)
                    }
                    .padding(.top, Theme.Spacing.lg)
                    
                    // Terms
                    if isSignUpMode {
                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                Text("By signing up, you agree to our")
                                    .font(Theme.Typography.footnote)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                
                                Button("Terms of Use") {}
                                    .font(Theme.Typography.footnote)
                                    .foregroundColor(Theme.Colors.primary)
                            }
                            
                            HStack(spacing: 4) {
                                Text("and")
                                    .font(Theme.Typography.footnote)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                
                                Button("Privacy Policy") {}
                                    .font(Theme.Typography.footnote)
                                    .foregroundColor(Theme.Colors.primary)
                            }
                        }
                        .multilineTextAlignment(.center)
                        .padding(.top, Theme.Spacing.lg)
                    }
                }
                .padding(Theme.Spacing.lg)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            MainTabView()
                .environmentObject(authService)
        }
        .navigationDestination(isPresented: $showForgotPassword) {
            ForgotPasswordView()
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    private func handleAuth() {
        // Validate inputs
        guard !email.isEmpty else {
            errorMessage = "Please enter your email"
            showError = true
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Please enter your password"
            showError = true
            return
        }
        
        if isSignUpMode {
            guard !name.isEmpty else {
                errorMessage = "Please enter your name"
                showError = true
                return
            }
            
            if authService.signUp(email: email, password: password, name: name) {
                navigateToHome = true
            } else {
                errorMessage = "Failed to create account"
                showError = true
            }
        } else {
            if authService.login(email: email, password: password) {
                navigateToHome = true
            } else {
                errorMessage = "Invalid email or password"
                showError = true
            }
        }
    }
    
    // MARK: - OAuth Handlers
    
    private func handleAppleSignIn() {
        oauthService.signInWithApple { result in
            switch result {
            case .success(let userData):
                // Create user with OAuth data
                DispatchQueue.main.async {
                    if self.authService.signUp(email: userData.email, password: "oauth_apple", name: userData.name) {
                        self.navigateToHome = true
                    } else {
                        self.errorMessage = "Failed to create account with Apple Sign-In"
                        self.showError = true
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                }
            }
        }
    }
}

// MARK: - Social Login Button
struct SocialLoginButton: View {
    let icon: String
    let action: () -> Void
    let isLoading: Bool
    
    init(icon: String, action: @escaping () -> Void, isLoading: Bool = false) {
        self.icon = icon
        self.action = action
        self.isLoading = isLoading
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Theme.Colors.textPrimary))
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(Theme.Colors.textPrimary)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.white)
            .cornerRadius(Theme.CornerRadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                    .stroke(Theme.Colors.textSecondary.opacity(0.2), lineWidth: 1)
            )
        }
        .disabled(isLoading)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
