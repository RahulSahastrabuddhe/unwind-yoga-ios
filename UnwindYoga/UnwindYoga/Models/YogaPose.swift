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
        ),
        YogaPose(
            name: "Plank Pose",
            sanskritName: "Phalakasana",
            description: "Hold a push-up position with arms straight, body in a straight line from head to heels. Engage core and keep hips level. Builds full-body strength and stability.",
            benefits: ["Strengthens core", "Builds arm strength", "Improves posture"],
            difficulty: .beginner,
            duration: 30,
            category: .balancing
        ),
        YogaPose(
            name: "Cat-Cow Pose",
            sanskritName: "Marjaryasana-Bitilasana",
            description: "On hands and knees, alternate between arching back (cow) and rounding spine (cat). Move with breath. Gentle warm-up that increases spinal flexibility.",
            benefits: ["Increases flexibility", "Warms up spine", "Relieves back tension"],
            difficulty: .beginner,
            duration: 45,
            category: .restorative
        ),
        YogaPose(
            name: "Extended Side Angle",
            sanskritName: "Utthita Parsvakonasana",
            description: "From Warrior II, lower front arm to thigh or floor. Extend top arm over ear. Creates a long line from back foot to fingertips. Strengthens and stretches entire side body.",
            benefits: ["Strengthens legs", "Stretches sides", "Improves stamina"],
            difficulty: .intermediate,
            duration: 45,
            category: .standing
        ),
        YogaPose(
            name: "Chair Pose",
            sanskritName: "Utkatasana",
            description: "Stand with feet together, bend knees as if sitting in a chair. Raise arms overhead. Keep weight in heels. Powerful pose that builds leg and core strength.",
            benefits: ["Strengthens legs", "Tones core", "Builds endurance"],
            difficulty: .beginner,
            duration: 30,
            category: .standing
        ),
        YogaPose(
            name: "Camel Pose",
            sanskritName: "Ustrasana",
            description: "Kneel with knees hip-width apart. Place hands on lower back and arch backward. Advanced practitioners can reach for heels. Deep backbend that opens the heart.",
            benefits: ["Opens chest", "Stretches hip flexors", "Energizes body"],
            difficulty: .advanced,
            duration: 30,
            category: .backbend
        ),
        YogaPose(
            name: "Boat Pose",
            sanskritName: "Navasana",
            description: "Sit with knees bent, lift feet off floor. Extend arms forward parallel to floor. For more challenge, straighten legs. Core-strengthening pose that builds balance.",
            benefits: ["Strengthens core", "Improves balance", "Tones abs"],
            difficulty: .intermediate,
            duration: 30,
            category: .balancing
        ),
        YogaPose(
            name: "Warrior III",
            sanskritName: "Virabhadrasana III",
            description: "From standing, hinge forward and lift one leg behind you. Extend arms forward. Body forms a T-shape. Challenging balance pose that builds focus and strength.",
            benefits: ["Improves balance", "Strengthens legs", "Enhances focus"],
            difficulty: .advanced,
            duration: 30,
            category: .balancing
        ),
        YogaPose(
            name: "Half Lord of the Fishes",
            sanskritName: "Ardha Matsyendrasana",
            description: "Sit with one leg bent, other leg crossed over. Twist torso toward bent knee, using arm for leverage. Detoxifying twist that improves spinal mobility.",
            benefits: ["Improves digestion", "Increases spinal mobility", "Detoxifies organs"],
            difficulty: .intermediate,
            duration: 45,
            category: .twist
        ),
        YogaPose(
            name: "Legs Up the Wall",
            sanskritName: "Viparita Karani",
            description: "Lie on back with legs extended up a wall. Arms rest at sides. Gentle inversion that promotes relaxation and reduces swelling in legs.",
            benefits: ["Reduces leg swelling", "Calms nervous system", "Relieves tired legs"],
            difficulty: .beginner,
            duration: 300,
            category: .restorative
        ),
        YogaPose(
            name: "Eagle Pose",
            sanskritName: "Garudasana",
            description: "Stand on one leg, wrap other leg around standing leg. Cross arms and wrap forearms. Challenging balance pose that opens shoulders and hips.",
            benefits: ["Improves balance", "Opens shoulders", "Strengthens ankles"],
            difficulty: .intermediate,
            duration: 30,
            category: .balancing
        ),
        YogaPose(
            name: "Upward-Facing Dog",
            sanskritName: "Urdhva Mukha Svanasana",
            description: "From lying face down, press hands into floor and lift chest and thighs off ground. Only hands and tops of feet touch floor. Energizing backbend.",
            benefits: ["Opens chest", "Strengthens arms", "Improves posture"],
            difficulty: .intermediate,
            duration: 30,
            category: .backbend
        ),
        YogaPose(
            name: "Happy Baby",
            sanskritName: "Ananda Balasana",
            description: "Lie on back, bring knees toward chest. Grab outside edges of feet and gently pull knees toward armpits. Rock side to side. Playful hip opener.",
            benefits: ["Opens hips", "Releases lower back", "Calms mind"],
            difficulty: .beginner,
            duration: 60,
            category: .restorative
        ),
        YogaPose(
            name: "Revolved Triangle",
            sanskritName: "Parivrtta Trikonasana",
            description: "From standing, step one foot back. Twist torso and reach opposite hand to front foot. Other arm extends up. Challenging twist that improves balance.",
            benefits: ["Improves balance", "Strengthens legs", "Detoxifies organs"],
            difficulty: .advanced,
            duration: 45,
            category: .twist
        ),
        YogaPose(
            name: "Sphinx Pose",
            sanskritName: "Salamba Bhujangasana",
            description: "Lie face down, prop upper body on forearms. Elbows under shoulders. Gentle backbend that strengthens spine and opens chest.",
            benefits: ["Strengthens spine", "Opens chest", "Gentle backbend"],
            difficulty: .beginner,
            duration: 45,
            category: .backbend
        ),
        YogaPose(
            name: "Side Plank",
            sanskritName: "Vasisthasana",
            description: "From plank, shift weight to one hand and outer edge of foot. Stack feet and extend top arm up. Challenging balance that builds core and arm strength.",
            benefits: ["Strengthens core", "Builds arm strength", "Improves balance"],
            difficulty: .intermediate,
            duration: 30,
            category: .balancing
        )
    ]
}
