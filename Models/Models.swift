import Foundation

struct Cat: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var breed: String
    var birthDate: Date
    var species: CatSpecies = .domestic
    var photoData: Data?
    var weightHistory: [WeightEntry] = []
    var vaccinationRecords: [VaccinationRecord] = []
    var isSpayedNeutered: Bool = false
    var microchipID: String = ""
    var insuranceInfo: String = ""
    var vetNotes: String = ""
    var emergencyContact: String = ""
    var healthScore: Int = 75
    var createdAt: Date = Date()
}

struct WeightEntry: Codable {
    var date: Date
    var weight: Double // in kg
}

struct VaccinationRecord: Codable {
    var name: String
    var date: Date
    var nextDueDate: Date?
    var vetName: String = ""
}

enum CatSpecies: String, Codable, CaseIterable {
    case domestic = "Domestic Shorthair"
    case longhair = "Domestic Longhair"
    case persian = "Persian"
    case siamese = "Siamese"
    case maineCoon = "Maine Coon"
    case ragdoll = "Ragdoll"
    case britishShorthair = "British Shorthair"
    case bengal = "Bengal"
    case abyssinian = "Abyssinian"
    case scottishFold = "Scottish Fold"
    case other = "Other"

    var icon: String {
        switch self {
        case .domestic: return "cat"
        case .longhair: return "cat.fill"
        case .persian: return "cat.circle"
        case .siamese: return "cat.fill.circle"
        case .mainCoon: return "lion"
        default: return "cat"
        }
    }
}

enum TaskCategory: String, Codable, CaseIterable {
    case feeding = "Feeding"
    case water = "Water"
    case litter = "Litter"
    case play = "Play"
    case grooming = "Grooming"
    case medication = "Medication"

    var icon: String {
        switch self {
        case .feeding: return "fork.knife"
        case .water: return "drop.fill"
        case .litter: return "trash.fill"
        case .play: return "play.fill"
        case .grooming: return "brush.fill"
        case .medication: return "pills.fill"
        }
    }

    var color: String {
        switch self {
        case .feeding: return "#FF8C42"
        case .water: return "#20B2AA"
        case .litter: return "#D4AF37"
        case .play: return "#FF6B6B"
        case .grooming: return "#9B59B6"
        case .medication: return "#3498DB"
        }
    }
}

struct CareTask: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var category: TaskCategory
    var scheduledTime: Date
    var catId: String
    var isCompleted: Bool = false
    var notes: String = ""
    var isRecurring: Bool = false
    var recurrenceInterval: Int = 1 // days
}

enum ArticleCategory: String, Codable, CaseIterable {
    case behavior = "Behavior"
    case health = "Health"
    case nutrition = "Nutrition"
    case training = "Training"

    var icon: String {
        switch self {
        case .behavior: return "brain.head.profile"
        case .health: return "heart.fill"
        case .nutrition: return "leaf.fill"
        case .training: return "star.fill"
        }
    }

    var color: String {
        switch self {
        case .behavior: return "#9B59B6"
        case .health: return "#E74C3C"
        case .nutrition: return "#27AE60"
        case .training: return "#F39C12"
        }
    }
}

struct Article: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var summary: String
    var category: ArticleCategory
    var imageData: Data?
    var content: String = ""
    var isPremium: Bool = false
    var readTime: Int = 5 // minutes
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