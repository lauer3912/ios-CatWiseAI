import UIKit
import SnapKit

class HomeViewController: UIViewController {

    private let dbService = DatabaseService.shared
    private var cats: [Cat] = []
    private var tasks: [CareTask] = []

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // Header
    private let greetingLabel = UILabel()
    private let streakBadge = UIView()

    // Cat Card
    private let catCard = UIView()
    private let catImageView = UIImageView()
    private let catNameLabel = UILabel()
    private let catBreedLabel = UILabel()
    private let healthScoreLabel = UILabel()

    // Tasks Section
    private let tasksLabel = UILabel()
    private let tasksStackView = UIStackView()

    // AI Insight
    private let insightCard = UIView()
    private let insightLabel = UILabel()

    // Quick Actions
    private let quickActionsStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    private func setupUI() {
        view.backgroundColor = Theme.Colors.backgroundDark
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupScrollView()
        setupHeader()
        setupCatCard()
        setupTasksSection()
        setupInsightCard()
        setupQuickActions()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.showsVerticalScrollIndicator = false

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }

    private func setupHeader() {
        greetingLabel.font = Theme.Font.largeTitle()
        greetingLabel.textColor = Theme.Colors.textPrimary
        greetingLabel.text = getGreeting()
        contentView.addSubview(greetingLabel)
        greetingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Spacing.lg)
            make.leading.equalToSuperview().offset(Theme.Spacing.lg)
        }

        // Streak badge
        streakBadge.backgroundColor = Theme.Colors.accent.withAlphaComponent(0.2)
        streakBadge.layer.cornerRadius = 16
        contentView.addSubview(streakBadge)
        streakBadge.snp.makeConstraints { make in
            make.centerY.equalTo(greetingLabel)
            make.trailing.equalToSuperview().offset(-Theme.Spacing.lg)
            make.height.equalTo(32)
            make.width.equalTo(80)
        }

        let flameIcon = UIImageView(image: UIImage(systemName: "flame.fill"))
        flameIcon.tintColor = Theme.Colors.accent
        streakBadge.addSubview(flameIcon)
        flameIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(18)
        }

        let streakLabel = UILabel()
        streakLabel.font = Theme.Font.headline()
        streakLabel.textColor = Theme.Colors.accent
        streakLabel.tag = 100
        streakBadge.addSubview(streakLabel)
        streakLabel.snp.makeConstraints { make in
            make.leading.equalTo(flameIcon.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }

    private func setupCatCard() {
        catCard.backgroundColor = Theme.Colors.backgroundCard
        catCard.layer.cornerRadius = Theme.CornerRadius.xl
        Theme.Shadow.apply(to: catCard)
        contentView.addSubview(catCard)
        catCard.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom).offset(Theme.Spacing.lg)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }

        // Cat image placeholder
        catImageView.backgroundColor = Theme.Colors.backgroundElevated
        catImageView.layer.cornerRadius = 40
        catImageView.contentMode = .scaleAspectFill
        catImageView.clipsToBounds = true
        catCard.addSubview(catImageView)
        catImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Theme.Spacing.lg)
            make.size.equalTo(80)
        }

        catNameLabel.font = Theme.Font.title2()
        catNameLabel.textColor = Theme.Colors.textPrimary
        catCard.addSubview(catNameLabel)
        catNameLabel.snp.makeConstraints { make in
            make.top.equalTo(catImageView)
            make.leading.equalTo(catImageView.snp.trailing).offset(Theme.Spacing.md)
        }

        catBreedLabel.font = Theme.Font.subhead()
        catBreedLabel.textColor = Theme.Colors.textSecondary
        catCard.addSubview(catBreedLabel)
        catBreedLabel.snp.makeConstraints { make in
            make.top.equalTo(catNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(catNameLabel)
        }

        healthScoreLabel.font = Theme.Font.headline()
        catCard.addSubview(healthScoreLabel)
        healthScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(catBreedLabel.snp.bottom).offset(Theme.Spacing.md)
            make.leading.equalTo(catNameLabel)
            make.bottom.equalToSuperview().offset(-Theme.Spacing.lg)
        }

        // Health ring
        let ringView = UIView()
        ringView.backgroundColor = Theme.Colors.primary.withAlphaComponent(0.2)
        ringView.layer.cornerRadius = 30
        catCard.addSubview(ringView)
        ringView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Theme.Spacing.lg)
            make.centerY.equalToSuperview()
            make.size.equalTo(60)
        }

        let scoreLabel = UILabel()
        scoreLabel.font = Theme.Font.title2()
        scoreLabel.textColor = Theme.Colors.primary
        scoreLabel.textAlignment = .center
        scoreLabel.tag = 200
        ringView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func setupTasksSection() {
        tasksLabel.text = "Today's Tasks"
        tasksLabel.font = Theme.Font.title3()
        tasksLabel.textColor = Theme.Colors.textPrimary
        contentView.addSubview(tasksLabel)
        tasksLabel.snp.makeConstraints { make in
            make.top.equalTo(catCard.snp.bottom).offset(Theme.Spacing.lg)
            make.leading.equalToSuperview().offset(Theme.Spacing.lg)
        }

        tasksStackView.axis = .vertical
        tasksStackView.spacing = Theme.Spacing.sm
        contentView.addSubview(tasksStackView)
        tasksStackView.snp.makeConstraints { make in
            make.top.equalTo(tasksLabel.snp.bottom).offset(Theme.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }
    }

    private func setupInsightCard() {
        insightCard.backgroundColor = Theme.Colors.backgroundCard
        insightCard.layer.cornerRadius = Theme.CornerRadius.large
        insightCard.layer.borderWidth = 1
        insightCard.layer.borderColor = Theme.Colors.primary.withAlphaComponent(0.3).cgColor
        contentView.addSubview(insightCard)
        insightCard.snp.makeConstraints { make in
            make.top.equalTo(tasksStackView.snp.bottom).offset(Theme.Spacing.lg)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }

        let insightIcon = UIImageView(image: UIImage(systemName: "lightbulb.fill"))
        insightIcon.tintColor = Theme.Colors.primary
        insightCard.addSubview(insightIcon)
        insightIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.size.equalTo(24)
        }

        let insightTitle = UILabel()
        insightTitle.text = "AI Insight"
        insightTitle.font = Theme.Font.headline()
        insightTitle.textColor = Theme.Colors.primary
        insightCard.addSubview(insightTitle)
        insightTitle.snp.makeConstraints { make in
            make.centerY.equalTo(insightIcon)
            make.leading.equalTo(insightIcon.snp.trailing).offset(Theme.Spacing.sm)
        }

        insightLabel.font = Theme.Font.body()
        insightLabel.textColor = Theme.Colors.textSecondary
        insightLabel.numberOfLines = 3
        insightLabel.text = "Luna used litter box 4 times today - healthy hydration!"
        insightCard.addSubview(insightLabel)
        insightLabel.snp.makeConstraints { make in
            make.top.equalTo(insightIcon.snp.bottom).offset(Theme.Spacing.sm)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.md)
            make.bottom.equalToSuperview().offset(-Theme.Spacing.md)
        }
    }

    private func setupQuickActions() {
        let actionsLabel = UILabel()
        actionsLabel.text = "Quick Log"
        actionsLabel.font = Theme.Font.title3()
        actionsLabel.textColor = Theme.Colors.textPrimary
        contentView.addSubview(actionsLabel)
        actionsLabel.snp.makeConstraints { make in
            make.top.equalTo(insightCard.snp.bottom).offset(Theme.Spacing.lg)
            make.leading.equalToSuperview().offset(Theme.Spacing.lg)
        }

        quickActionsStack.axis = .horizontal
        quickActionsStack.spacing = Theme.Spacing.md
        quickActionsStack.distribution = .fillEqually
        contentView.addSubview(quickActionsStack)
        quickActionsStack.snp.makeConstraints { make in
            make.top.equalTo(actionsLabel.snp.bottom).offset(Theme.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
            make.height.equalTo(70)
            make.bottom.equalToSuperview().offset(-Theme.Spacing.lg)
        }

        let actions = [("Meal", "fork.knife"), ("Weight", "scalemass"), ("Water", "drop.fill"), ("Play", "play.fill")]
        for (title, icon) in actions {
            let btn = createQuickActionButton(title: title, icon: icon)
            quickActionsStack.addArrangedSubview(btn)
        }
    }

    private func createQuickActionButton(title: String, icon: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = Theme.Colors.backgroundCard
        button.layer.cornerRadius = Theme.CornerRadius.medium

        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.isUserInteractionEnabled = false
        button.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = Theme.Colors.primary
        iconView.contentMode = .scaleAspectFit
        iconView.snp.makeConstraints { make in make.size.equalTo(24) }
        stack.addArrangedSubview(iconView)

        let label = UILabel()
        label.text = title
        label.font = Theme.Font.caption()
        label.textColor = Theme.Colors.textSecondary
        stack.addArrangedSubview(label)

        return button
    }

    private func loadData() {
        dbService.createSampleDataIfNeeded()
        cats = dbService.loadCats()
        tasks = dbService.loadTasks()

        updateUI()
    }

    private func updateUI() {
        // Update greeting
        greetingLabel.text = getGreeting()

        // Update streak
        let profile = dbService.loadUserProfile()
        if let streakLabel = streakBadge.viewWithTag(100) as? UILabel {
            streakLabel.text = "\(profile.streakDays) days"
        }

        // Update cat card
        if let cat = cats.first {
            catNameLabel.text = cat.name
            catBreedLabel.text = "\(cat.species.rawValue) • \(cat.breed)"
            healthScoreLabel.text = "Health: \(cat.healthScore)/100"
            healthScoreLabel.textColor = cat.healthScore > 70 ? Theme.Colors.success : Theme.Colors.warning
            if let scoreLabel = catCard.viewWithTag(200) as? UILabel {
                scoreLabel.text = "\(cat.healthScore)"
            }
        }

        // Update tasks
        tasksStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let todayTasks = tasks.prefix(4)
        for task in todayTasks {
            let taskView = createTaskView(task)
            tasksStackView.addArrangedSubview(taskView)
        }
    }

    private func createTaskView(_ task: CareTask) -> UIView {
        let view = UIView()
        view.backgroundColor = Theme.Colors.backgroundCard
        view.layer.cornerRadius = Theme.CornerRadius.medium

        let iconView = UIImageView(image: UIImage(systemName: task.category.icon))
        iconView.tintColor = UIColor(hex: task.category.color)
        view.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        let titleLabel = UILabel()
        titleLabel.text = task.title
        titleLabel.font = Theme.Font.body()
        titleLabel.textColor = Theme.Colors.textPrimary
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
        }

        let timeLabel = UILabel()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeLabel.text = formatter.string(from: task.scheduledTime)
        timeLabel.font = Theme.Font.caption()
        timeLabel.textColor = Theme.Colors.textMuted
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Theme.Spacing.md)
            make.centerY.equalToSuperview()
        }

        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        return view
    }

    private func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good Morning" }
        if hour < 17 { return "Good Afternoon" }
        return "Good Evening"
    }
}