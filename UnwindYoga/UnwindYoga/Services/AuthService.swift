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
        loadCurrentUser()
    }
    
    // MARK: - Authentication Methods
    
    func signUp(email: String, password: String, name: String) -> Bool {
        // For MVP, we're just storing locally
        // In production, this would connect to a backend
        
        guard !email.isEmpty, !password.isEmpty, !name.isEmpty else {
            return false
        }
        
        // Check if user already exists
        if let existingUsers = loadAllUsers(), existingUsers.contains(where: { $0.email == email }) {
            print("❌ User with email \(email) already exists")
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
        
        if let allUsers = loadAllUsers() {
            if let foundUser = allUsers.first(where: { $0.email == email }) {
                currentUser = foundUser
                isAuthenticated = true
                print("✅ User logged in: \(email)")
                return true
            }
        }
        
        print("❌ No user found with email: \(email)")
        return false
    }
    
    func logout() {
        currentUser = nil
        isAuthenticated = false
        // Don't remove user data from UserDefaults - keep the account for future login
        print("✅ User logged out successfully")
    }
    
    func deleteAccount() -> Bool {
        // Clear all user data
        currentUser = nil
        isAuthenticated = false
        
        // Remove user from UserDefaults
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        
        // Remove any progress data
        UserDefaults.standard.removeObject(forKey: "unwindyoga_progress")
        
        print("✅ Account deleted successfully")
        return true
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
        var allUsers = loadAllUsers() ?? []
        
        // Remove existing user with same email if exists
        allUsers.removeAll { $0.email == user.email }
        
        // Add new user
        allUsers.append(user)
        
        // Save all users
        if let encoded = try? JSONEncoder().encode(allUsers) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadCurrentUser() {
        // Try to load as array first (new format)
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            // Try to decode as array of users
            if let users = try? JSONDecoder().decode([User].self, from: data), !users.isEmpty {
                currentUser = users.first
                isAuthenticated = true
                return
            }
            
            // Try to decode as single user (old format) and migrate
            if let singleUser = try? JSONDecoder().decode(User.self, from: data) {
                currentUser = singleUser
                isAuthenticated = true
                // Migrate to new format
                saveUser(singleUser)
                return
            }
        }
        
        // No user found
        currentUser = nil
        isAuthenticated = false
    }
    
    private func loadUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let users = try? JSONDecoder().decode([User].self, from: data),
              let firstUser = users.first else {
            return nil
        }
        return firstUser
    }
    
    private func loadAllUsers() -> [User]? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let users = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        return users
    }
}
