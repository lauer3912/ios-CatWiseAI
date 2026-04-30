import Foundation

struct Cat: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var breed: String
    var birthDate: Date
    var photoData: Data?
    var weightHistory: [WeightEntry] = []
    var healthScore: Int = 75
    var isSpayedNeutered: Bool = false
    var microchipID: String = ""
    var vetNotes: String = ""
    var createdAt: Date = Date()
}

struct WeightEntry: Codable {
    var date: Date
    var weight: Double
}

struct CareTask: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var category: TaskCategory
    var scheduledTime: Date
    var petId: String
    var isCompleted: Bool = false
    var notes: String = ""
}

enum TaskCategory: String, Codable, CaseIterable {
    case feeding = "Feeding"
    case litter = "Litter"
    case grooming = "Grooming"
    case vet = "Vet Visit"
    case play = "Play"
    case medication = "Medication"

    var icon: String {
        switch self {
        case .feeding: return "fork.knife"
        case .litter: return "drop.fill"
        case .grooming: return "brush.fill"
        case .vet: return "stethoscope"
        case .play: return "play.fill"
        case .medication: return "pills.fill"
        }
    }
}

struct UserProfile: Codable {
    var name: String = ""
    var avatarData: Data?
    var level: Int = 1
    var xp: Int = 0
    var totalTasksCompleted: Int = 0
    var streakDays: Int = 0
    var catsOwned: Int = 0
    var isPremium: Bool = false
}