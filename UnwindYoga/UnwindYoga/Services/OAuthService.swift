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
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        
        // Store completion handler
        self.appleSignInCompletion = completion
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
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let email = appleIDCredential.email ?? "apple_user_\(appleIDCredential.user)@privaterelay.appleid.com"
            let firstName = appleIDCredential.fullName?.givenName ?? ""
            let lastName = appleIDCredential.fullName?.familyName ?? ""
            let name = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
            let finalName = name.isEmpty ? "Apple User" : name
            
            appleSignInCompletion?(.success((email: email, name: finalName)))
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleSignInCompletion?(.failure(error))
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
