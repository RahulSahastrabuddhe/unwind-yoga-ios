//
//  AuthService.swift
//  UnwindYoga
//
//  Service for handling authentication and user data
//

import Foundation
import Combine

class AuthService: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    
    private let userDefaultsKey = "unwindyoga_user"
    
    init() {
        loadUser()
    }
    
    // MARK: - Authentication Methods
    
    func signUp(email: String, password: String, name: String) -> Bool {
        // For MVP, we're just storing locally
        // In production, this would connect to a backend
        
        guard !email.isEmpty, !password.isEmpty, !name.isEmpty else {
            return false
        }
        
        let newUser = User(email: email, name: name)
        saveUser(newUser)
        currentUser = newUser
        isAuthenticated = true
        return true
    }
    
    func login(email: String, password: String) -> Bool {
        // For MVP, we're just checking if user exists
        // In production, this would validate credentials with backend
        
        guard !email.isEmpty, !password.isEmpty else {
            return false
        }
        
        if let savedUser = loadUser() {
            if savedUser.email == email {
                currentUser = savedUser
                isAuthenticated = true
                return true
            }
        }
        
        return false
    }
    
    func logout() {
        currentUser = nil
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
    
    func continueAsGuest() {
        let guestUser = User(email: "guest@unwindyoga.app", name: "Guest User")
        currentUser = guestUser
        isAuthenticated = true
        // Don't save guest user to UserDefaults
    }
    
    func updateUser(_ user: User) {
        currentUser = user
        saveUser(user)
    }
    
    func completeOnboarding(experienceLevel: YogaPose.Difficulty, goals: [User.Goal], practiceTime: Date?) {
        guard var user = currentUser else { return }
        
        user.hasCompletedOnboarding = true
        user.experienceLevel = experienceLevel
        user.goals = goals
        user.preferredPracticeTime = practiceTime
        
        updateUser(user)
    }
    
    // MARK: - Private Methods
    
    private func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    @discardableResult
    private func loadUser() -> User? {
        if let savedUser = UserDefaults.standard.data(forKey: userDefaultsKey),
           let user = try? JSONDecoder().decode(User.self, from: savedUser) {
            currentUser = user
            isAuthenticated = true
            return user
        }
        return nil
    }
}
