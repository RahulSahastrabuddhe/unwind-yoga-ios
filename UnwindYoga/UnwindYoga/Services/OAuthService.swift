//
//  OAuthService.swift
//  UnwindYoga
//
//  Service for handling OAuth authentication (Apple, Google)
//

import Foundation
import Combine
import AuthenticationServices

class OAuthService: NSObject, ObservableObject {
    @Published var isAuthenticating = false
    
    // MARK: - Sign in with Apple
    
    func signInWithApple(completion: @escaping (Result<(email: String, name: String), Error>) -> Void) {
        isAuthenticating = true
        
        print("🍎 Starting Apple Sign-In...")
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        // Store completion handler with proper memory management
        self.appleSignInCompletion = { [weak self] result in
            DispatchQueue.main.async {
                self?.isAuthenticating = false
                completion(result)
            }
        }
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        print("🍎 Performing Apple Sign-In request...")
        controller.performRequests()
    }
    
    // MARK: - Sign in with Google
    
    func signInWithGoogle(completion: @escaping (Result<(email: String, name: String), Error>) -> Void) {
        // TODO: Implement Google Sign-In
        // Requires: GoogleSignIn SDK
        // Steps:
        // 1. Add GoogleSignIn pod/package
        // 2. Configure Google Cloud Console
        // 3. Add URL scheme to Info.plist
        // 4. Implement GIDSignIn
        
        // For now, show alert that it's not implemented
        completion(.failure(OAuthError.notImplemented("Google Sign-In requires additional setup. Please use email/password for now.")))
    }
    
    // MARK: - Private
    
    private var appleSignInCompletion: ((Result<(email: String, name: String), Error>) -> Void)?
}

// MARK: - ASAuthorizationControllerDelegate

extension OAuthService: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("🍎 Apple Sign-In authorization received")
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Handle email - Apple may not provide email if user hides it
            var email: String
            if let appleEmail = appleIDCredential.email, !appleEmail.isEmpty {
                email = appleEmail
            } else {
                // Use private relay email or generate a placeholder
                email = "apple_user_\(appleIDCredential.user)@privaterelay.appleid.com"
            }
            
            // Handle name - Apple may not provide name
            let firstName = appleIDCredential.fullName?.givenName ?? ""
            let lastName = appleIDCredential.fullName?.familyName ?? ""
            let name = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
            let finalName = name.isEmpty ? "Apple User" : name
            
            print("✅ Apple Sign-In successful: \(email)")
            appleSignInCompletion?(.success((email: email, name: finalName)))
        } else {
            print("❌ Unexpected credential type received")
            appleSignInCompletion?(.failure(OAuthError.failed("Unexpected credential type")))
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("❌ Apple Sign-In failed: \(error.localizedDescription)")
        print("❌ Error details: \(error)")
        
        // Handle specific Apple Sign-In errors
        if let authError = error as? ASAuthorizationError {
            switch authError.code {
            case .canceled:
                print("🍎 User cancelled Apple Sign-In")
                appleSignInCompletion?(.failure(OAuthError.cancelled))
            case .failed:
                print("🍎 Apple Sign-In failed")
                appleSignInCompletion?(.failure(OAuthError.failed("Apple Sign-In failed. Please try again.")))
            case .invalidResponse:
                print("🍎 Invalid response from Apple")
                appleSignInCompletion?(.failure(OAuthError.failed("Invalid response from Apple.")))
            case .notHandled:
                print("🍎 Apple Sign-In not handled")
                appleSignInCompletion?(.failure(OAuthError.failed("Apple Sign-In not handled.")))
            case .unknown:
                print("🍎 Unknown Apple Sign-In error")
                appleSignInCompletion?(.failure(OAuthError.failed("Unknown error occurred.")))
            @unknown default:
                print("🍎 Unhandled Apple Sign-In error")
                appleSignInCompletion?(.failure(error))
            }
        } else {
            print("🍎 Non-Apple Sign-In error: \(error)")
            appleSignInCompletion?(.failure(error))
        }
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension OAuthService: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Get the key window safely
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            return window
        }
        
        // Fallback: Create a new window if needed
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            return window
        }
        
        // Last resort: Use the main window
        return UIApplication.shared.windows.first ?? UIWindow()
    }
}

// MARK: - OAuth Error

enum OAuthError: LocalizedError {
    case notImplemented(String)
    case cancelled
    case failed(String)
    
    var errorDescription: String? {
        switch self {
        case .notImplemented(let message):
            return message
        case .cancelled:
            return "Sign in was cancelled"
        case .failed(let message):
            return message
        }
    }
}
