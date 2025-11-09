//
//  YogaPose.swift
//  UnwindYoga
//
//  Model for yoga poses
//

import Foundation

struct YogaPose: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let sanskritName: String
    let description: String
    let benefits: [String]
    let difficulty: Difficulty
    let duration: Int // in seconds
    let category: Category
    let imageName: String
    
    enum Difficulty: String, Codable, CaseIterable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
    }
    
    enum Category: String, Codable, CaseIterable {
        case standing = "Standing"
        case seated = "Seated"
        case balancing = "Balancing"
        case backbend = "Backbend"
        case forward = "Forward Bend"
        case twist = "Twist"
        case inversion = "Inversion"
        case restorative = "Restorative"
    }
    
    init(id: UUID = UUID(), name: String, sanskritName: String, description: String, benefits: [String], difficulty: Difficulty, duration: Int, category: Category, imageName: String = "placeholder") {
        self.id = id
        self.name = name
        self.sanskritName = sanskritName
        self.description = description
        self.benefits = benefits
        self.difficulty = difficulty
        self.duration = duration
        self.category = category
        self.imageName = imageName
    }
}

// MARK: - Sample Data
extension YogaPose {
    static let samplePoses: [YogaPose] = [
        YogaPose(
            name: "Mountain Pose",
            sanskritName: "Tadasana",
            description: "Stand tall with feet together, arms at sides. Ground through your feet, engage your thighs, and reach the crown of your head toward the sky. This foundational pose improves posture and balance.",
            benefits: ["Improves posture", "Strengthens thighs", "Increases awareness"],
            difficulty: .beginner,
            duration: 30,
            category: .standing
        ),
        YogaPose(
            name: "Downward-Facing Dog",
            sanskritName: "Adho Mukha Svanasana",
            description: "From hands and knees, lift hips up and back, forming an inverted V-shape. Press hands firmly into the mat, straighten legs, and relax your head between your arms.",
            benefits: ["Stretches hamstrings", "Strengthens arms", "Energizes body"],
            difficulty: .beginner,
            duration: 60,
            category: .inversion
        ),
        YogaPose(
            name: "Warrior I",
            sanskritName: "Virabhadrasana I",
            description: "Step one foot back, bend front knee to 90 degrees, and raise arms overhead. Keep hips square and gaze forward. This powerful pose builds strength and focus.",
            benefits: ["Strengthens legs", "Opens hips", "Builds confidence"],
            difficulty: .beginner,
            duration: 45,
            category: .standing
        ),
        YogaPose(
            name: "Warrior II",
            sanskritName: "Virabhadrasana II",
            description: "From Warrior I, open hips and shoulders to the side, extending arms parallel to the floor. Gaze over front fingertips. This pose develops stamina and concentration.",
            benefits: ["Strengthens legs", "Opens hips", "Improves balance"],
            difficulty: .beginner,
            duration: 45,
            category: .standing
        ),
        YogaPose(
            name: "Tree Pose",
            sanskritName: "Vrksasana",
            description: "Stand on one leg, place the sole of the other foot on inner thigh or calf. Bring hands to prayer position at chest or extend overhead. Focus on a fixed point for balance.",
            benefits: ["Improves balance", "Strengthens legs", "Enhances focus"],
            difficulty: .beginner,
            duration: 30,
            category: .balancing
        ),
        YogaPose(
            name: "Child's Pose",
            sanskritName: "Balasana",
            description: "Kneel on the floor, sit back on heels, and fold forward with arms extended. Rest forehead on the mat. This gentle pose is perfect for rest and relaxation.",
            benefits: ["Relieves stress", "Stretches back", "Calms mind"],
            difficulty: .beginner,
            duration: 60,
            category: .restorative
        ),
        YogaPose(
            name: "Cobra Pose",
            sanskritName: "Bhujangasana",
            description: "Lie face down, place hands under shoulders, and gently lift chest off the floor. Keep elbows slightly bent and shoulders away from ears. Opens the heart and strengthens the spine.",
            benefits: ["Strengthens spine", "Opens chest", "Improves flexibility"],
            difficulty: .beginner,
            duration: 30,
            category: .backbend
        ),
        YogaPose(
            name: "Seated Forward Bend",
            sanskritName: "Paschimottanasana",
            description: "Sit with legs extended, hinge at hips to fold forward. Reach for feet or shins, keeping spine long. This calming pose stretches the entire back body.",
            benefits: ["Stretches hamstrings", "Calms mind", "Relieves stress"],
            difficulty: .intermediate,
            duration: 60,
            category: .forward
        ),
        YogaPose(
            name: "Triangle Pose",
            sanskritName: "Trikonasana",
            description: "Stand with feet wide, extend arms parallel to floor. Reach one hand down to shin or floor, other arm extends up. This pose stretches and strengthens the entire body.",
            benefits: ["Stretches sides", "Strengthens legs", "Improves digestion"],
            difficulty: .beginner,
            duration: 45,
            category: .standing
        ),
        YogaPose(
            name: "Pigeon Pose",
            sanskritName: "Eka Pada Rajakapotasana",
            description: "From downward dog, bring one knee forward between hands. Extend back leg straight behind. Fold forward over front leg. Deep hip opener that releases tension.",
            benefits: ["Opens hips", "Releases tension", "Stretches glutes"],
            difficulty: .intermediate,
            duration: 60,
            category: .seated
        ),
        YogaPose(
            name: "Bridge Pose",
            sanskritName: "Setu Bandha Sarvangasana",
            description: "Lie on back, bend knees with feet hip-width apart. Lift hips toward ceiling, interlace fingers under back. This energizing backbend opens the chest and strengthens the back.",
            benefits: ["Strengthens back", "Opens chest", "Energizes body"],
            difficulty: .beginner,
            duration: 45,
            category: .backbend
        ),
        YogaPose(
            name: "Corpse Pose",
            sanskritName: "Savasana",
            description: "Lie flat on back, arms at sides with palms up. Close eyes and relax completely. This final relaxation pose integrates the benefits of your practice.",
            benefits: ["Deep relaxation", "Reduces stress", "Integrates practice"],
            difficulty: .beginner,
            duration: 300,
            category: .restorative
        )
    ]
}
