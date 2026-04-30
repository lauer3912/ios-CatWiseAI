import Foundation

class DatabaseService {
    static let shared = DatabaseService()

    private let defaults = UserDefaults.standard

    // MARK: - Keys
    private enum Keys {
        static let cats = "whiskerwaves_cats"
        static let tasks = "whiskerwaves_tasks"
        static let articles = "whiskerwaves_articles"
        static let userProfile = "whiskerwaves_user"
        static let streakDate = "whiskerwaves_streak_date"
        static let lastTaskDate = "whiskerwaves_last_task_date"
    }

    private init() {}

    // MARK: - Cats
    func saveCats(_ cats: [Cat]) {
        if let data = try? JSONEncoder().encode(cats) {
            defaults.set(data, forKey: Keys.cats)
        }
    }

    func loadCats() -> [Cat] {
        guard let data = defaults.data(forKey: Keys.cats),
              let cats = try? JSONDecoder().decode([Cat].self, from: data) else {
            return []
        }
        return cats
    }

    func addCat(_ cat: Cat) {
        var cats = loadCats()
        cats.append(cat)
        saveCats(cats)
    }

    func updateCat(_ cat: Cat) {
        var cats = loadCats()
        if let index = cats.firstIndex(where: { $0.id == cat.id }) {
            cats[index] = cat
            saveCats(cats)
        }
    }

    func deleteCat(id: String) {
        var cats = loadCats()
        cats.removeAll { $0.id == id }
        saveCats(cats)
    }

    // MARK: - Tasks
    func saveTasks(_ tasks: [CareTask]) {
        if let data = try? JSONEncoder().encode(tasks) {
            defaults.set(data, forKey: Keys.tasks)
        }
    }

    func loadTasks() -> [CareTask] {
        guard let data = defaults.data(forKey: Keys.tasks),
              let tasks = try? JSONDecoder().decode([CareTask].self, from: data) else {
            return []
        }
        return tasks
    }

    func addTask(_ task: CareTask) {
        var tasks = loadTasks()
        tasks.append(task)
        saveTasks(tasks)
    }

    func completeTask(id: String) {
        var tasks = loadTasks()
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].isCompleted = true
            saveTasks(tasks)
            updateStreak()
        }
    }

    func deleteTask(id: String) {
        var tasks = loadTasks()
        tasks.removeAll { $0.id == id }
        saveTasks(tasks)
    }

    // MARK: - User Profile
    func saveUserProfile(_ profile: UserProfile) {
        if let data = try? JSONEncoder().encode(profile) {
            defaults.set(data, forKey: Keys.userProfile)
        }
    }

    func loadUserProfile() -> UserProfile {
        guard let data = defaults.data(forKey: Keys.userProfile),
              let profile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            return UserProfile()
        }
        return profile
    }

    func updateXP(amount: Int) {
        var profile = loadUserProfile()
        profile.xp += amount
        if profile.xp >= profile.level * 100 {
            profile.level += 1
            profile.xp = profile.xp - (profile.level - 1) * 100
        }
        saveUserProfile(profile)
    }

    // MARK: - Streak
    func updateStreak() {
        let today = Calendar.current.startOfDay(for: Date())
        if let lastDate = defaults.object(forKey: Keys.streakDate) as? Date {
            let lastDay = Calendar.current.startOfDay(for: lastDate)
            let diff = Calendar.current.dateComponents([.day], from: lastDay, to: today).day ?? 0
            if diff == 1 {
                var profile = loadUserProfile()
                profile.streakDays += 1
                saveUserProfile(profile)
            } else if diff > 1 {
                var profile = loadUserProfile()
                profile.streakDays = 1
                saveUserProfile(profile)
            }
        } else {
            var profile = loadUserProfile()
            profile.streakDays = 1
            saveUserProfile(profile)
        }
        defaults.set(today, forKey: Keys.streakDate)
    }

    // MARK: - Sample Data
    func createSampleDataIfNeeded() {
        if loadCats().isEmpty {
            let sampleCat = Cat(name: "Luna", breed: "British Shorthair", birthDate: Date().addingTimeInterval(-2 * 365 * 24 * 60 * 60), species: .britishShorthair, healthScore: 88)
            addCat(sampleCat)
        }

        if loadTasks().isEmpty {
            let tasks = createSampleTasks()
            saveTasks(tasks)
        }
    }

    private func createSampleTasks() -> [CareTask] {
        let cats = loadCats()
        guard let firstCat = cats.first else { return [] }

        let calendar = Calendar.current
        let today = Date()

        return [
            CareTask(title: "Breakfast", category: .feeding, scheduledTime: calendar.date(bySettingHour: 8, minute: 0, second: 0, of: today)!, catId: firstCat.id),
            CareTask(title: "Fresh water", category: .water, scheduledTime: calendar.date(bySettingHour: 9, minute: 0, second: 0, of: today)!, catId: firstCat.id),
            CareTask(title: "Litter check", category: .litter, scheduledTime: calendar.date(bySettingHour: 12, minute: 0, second: 0, of: today)!, catId: firstCat.id),
            CareTask(title: "Play session", category: .play, scheduledTime: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: today)!, catId: firstCat.id)
        ]
    }
}