//
//  ProgressService.swift
//  UnwindYoga
//
//  Service for tracking user progress and statistics
//

import Foundation
import Combine

class ProgressService: ObservableObject {
    @Published var weeklyGoal: Int = 5
    @Published var completedSessions: [Date] = []
    @Published var currentStreak: Int = 0
    @Published var totalPracticeTime: TimeInterval = 0
    
    private let userDefaultsKey = "unwindyoga_progress"
    private let calendar = Calendar.current
    
    init() {
        loadProgress()
    }
    
    // MARK: - Session Tracking
    
    func markSessionCompleted(duration: TimeInterval = 600) { // Default 10 minutes
        let today = Date()
        
        // Add to completed sessions
        completedSessions.append(today)
        
        // Update total practice time
        totalPracticeTime += duration
        
        // Update streak
        updateStreak()
        
        // Save progress
        saveProgress()
        
        print("✅ Session completed - Streak: \(currentStreak), Total sessions: \(completedSessions.count)")
    }
    
    func markDailyActivity() {
        let today = Date()
        
        // Check if already marked today
        if !hasActivityToday() {
            markSessionCompleted(duration: 0) // Mark as activity without duration
        }
    }
    
    // MARK: - Streak Management
    
    private func updateStreak() {
        let today = Date()
        let sortedSessions = completedSessions.sorted { $0 > $1 } // Most recent first
        
        guard !sortedSessions.isEmpty else {
            currentStreak = 0
            return
        }
        
        var streak = 0
        var currentDate = today
        
        for session in sortedSessions {
            if calendar.isDate(session, inSameDayAs: currentDate) {
                streak += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
            } else if calendar.isDate(session, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate) {
                // Check if it's yesterday (allowing for missed days)
                streak += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
            } else {
                // Gap in streak
                break
            }
        }
        
        currentStreak = streak
    }
    
    // MARK: - Weekly Progress
    
    func getWeeklyProgress() -> Int {
        let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return completedSessions.filter { $0 >= oneWeekAgo }.count
    }
    
    func getWeeklyGoalProgress() -> Double {
        let weeklyCompleted = getWeeklyProgress()
        return Double(weeklyCompleted) / Double(weeklyGoal)
    }
    
    // MARK: - Helper Methods
    
    func hasActivityToday() -> Bool {
        return completedSessions.contains { calendar.isDate($0, inSameDayAs: Date()) }
    }
    
    func getActivityForDate(_ date: Date) -> Bool {
        return completedSessions.contains { calendar.isDate($0, inSameDayAs: date) }
    }
    
    func getFormattedTotalTime() -> String {
        let hours = Int(totalPracticeTime) / 3600
        let minutes = Int(totalPracticeTime) % 3600 / 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    // MARK: - Data Persistence
    
    private func saveProgress() {
        let progressData = ProgressData(
            completedSessions: completedSessions,
            currentStreak: currentStreak,
            totalPracticeTime: totalPracticeTime
        )
        
        if let encoded = try? JSONEncoder().encode(progressData) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadProgress() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let progressData = try? JSONDecoder().decode(ProgressData.self, from: savedData) {
            completedSessions = progressData.completedSessions
            currentStreak = progressData.currentStreak
            totalPracticeTime = progressData.totalPracticeTime
            
            // Update streak based on current data
            updateStreak()
        }
    }
    
    func resetProgress() {
        completedSessions = []
        currentStreak = 0
        totalPracticeTime = 0
        saveProgress()
    }
}

// MARK: - Progress Data Model

private struct ProgressData: Codable {
    let completedSessions: [Date]
    let currentStreak: Int
    let totalPracticeTime: TimeInterval
}
