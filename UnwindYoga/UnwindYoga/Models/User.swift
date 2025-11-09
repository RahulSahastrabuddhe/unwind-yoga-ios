//
//  User.swift
//  UnwindYoga
//
//  Model for user data
//

import Foundation

struct User: Codable {
    var email: String
    var name: String
    var hasCompletedOnboarding: Bool
    var preferredPracticeTime: Date?
    var experienceLevel: YogaPose.Difficulty
    var goals: [Goal]
    
    enum Goal: String, Codable, CaseIterable {
        case flexibility = "Improve Flexibility"
        case strength = "Build Strength"
        case mindfulness = "Enhance Mindfulness"
        case weightLoss = "Support Weight Loss"
        case stressRelief = "Reduce Stress"
        case balance = "Better Balance"
    }
    
    init(email: String, name: String, hasCompletedOnboarding: Bool = false, preferredPracticeTime: Date? = nil, experienceLevel: YogaPose.Difficulty = .beginner, goals: [Goal] = []) {
        self.email = email
        self.name = name
        self.hasCompletedOnboarding = hasCompletedOnboarding
        self.preferredPracticeTime = preferredPracticeTime
        self.experienceLevel = experienceLevel
        self.goals = goals
    }
}
