//
//  YogaSession.swift
//  UnwindYoga
//
//  Model for yoga sessions
//

import Foundation

struct YogaSession: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let duration: Int // in minutes
    let difficulty: YogaPose.Difficulty
    let poseIds: [UUID]
    let imageName: String
    
    init(id: UUID = UUID(), name: String, description: String, duration: Int, difficulty: YogaPose.Difficulty, poseIds: [UUID], imageName: String = "session_placeholder") {
        self.id = id
        self.name = name
        self.description = description
        self.duration = duration
        self.difficulty = difficulty
        self.poseIds = poseIds
        self.imageName = imageName
    }
}

// MARK: - Sample Data
extension YogaSession {
    static func sampleSessions(poses: [YogaPose]) -> [YogaSession] {
        let beginnerPoses = poses.filter { $0.difficulty == .beginner }.prefix(5).map { $0.id }
        let intermediatePoses = poses.filter { $0.difficulty == .intermediate || $0.difficulty == .beginner }.prefix(6).map { $0.id }
        
        return [
            YogaSession(
                name: "Morning Energizer",
                description: "Start your day with this energizing 15-minute flow designed to wake up your body and mind.",
                duration: 15,
                difficulty: .beginner,
                poseIds: Array(beginnerPoses)
            ),
            YogaSession(
                name: "Evening Wind Down",
                description: "Relax and unwind after a long day with gentle stretches and calming poses.",
                duration: 20,
                difficulty: .beginner,
                poseIds: Array(beginnerPoses)
            ),
            YogaSession(
                name: "Strength Builder",
                description: "Build strength and stability with this challenging intermediate practice.",
                duration: 30,
                difficulty: .intermediate,
                poseIds: Array(intermediatePoses)
            )
        ]
    }
}
