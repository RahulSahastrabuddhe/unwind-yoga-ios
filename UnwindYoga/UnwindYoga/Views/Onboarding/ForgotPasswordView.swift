//
//  ForgotPasswordView.swift
//  UnwindYoga
//
//  Forgot password screen
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var showSuccess = false
    @State private var showError = false
    @State private var errorMessage = ""
    
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
                        
                        Text("Forgot Password?")
                            .font(Theme.Typography.title1)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        Text("Enter your email address and we'll send you instructions to reset your password.")
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, Theme.Spacing.xl)
                    
                    // Email Field
                    CustomTextField(
                        placeholder: "Email Address",
                        text: $email,
                        keyboardType: .emailAddress
                    )
                    .padding(.top, Theme.Spacing.xl)
                    
                    // Send Button
                    CustomButton(
                        title: "Send Reset Link",
                        action: handlePasswordReset
                    )
                    .padding(.top, Theme.Spacing.lg)
                    
                    // Back to Login
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.left")
                                .font(.caption)
                            
                            Text("Back to Login")
                                .font(Theme.Typography.body)
                        }
                        .foregroundColor(Theme.Colors.primary)
                    }
                    .padding(.top, Theme.Spacing.md)
                    
                    Spacer()
                }
                .padding(Theme.Spacing.lg)
            }
        }
        .navigationBarHidden(true)
        .alert("Check Your Email", isPresented: $showSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("We've sent password reset instructions to \(email)")
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    private func handlePasswordReset() {
        // Validate email
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address"
            showError = true
            return
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email address"
            showError = true
            return
        }
        
        // For MVP: Just show success message
        // In production: This would call your backend API
        showSuccess = true
    }
}

#Preview {
    ForgotPasswordView()
}
