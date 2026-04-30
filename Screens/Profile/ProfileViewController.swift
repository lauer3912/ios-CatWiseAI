import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    private let dbService = DatabaseService.shared

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    private func setupUI() {
        view.backgroundColor = Theme.Colors.backgroundDark
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupScrollView()
        setupAvatar()
        setupStats()
        setupPremiumCard()
        setupSettings()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }

    private func setupAvatar() {
        let avatarContainer = UIView()
        avatarContainer.backgroundColor = Theme.Colors.backgroundCard
        avatarContainer.layer.cornerRadius = 50
        avatarContainer.layer.borderWidth = 3
        avatarContainer.layer.borderColor = Theme.Colors.primary.cgColor
        contentView.addSubview(avatarContainer)
        avatarContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Spacing.xl)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }

        let avatarIcon = UIImageView(image: UIImage(systemName: "person.fill"))
        avatarIcon.tintColor = Theme.Colors.primary
        avatarIcon.contentMode = .scaleAspectFit
        avatarContainer.addSubview(avatarIcon)
        avatarIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }

        let nameLabel = UILabel()
        nameLabel.text = "Cat Parent"
        nameLabel.font = Theme.Font.title2()
        nameLabel.textColor = Theme.Colors.textPrimary
        nameLabel.textAlignment = .center
        nameLabel.tag = 100
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarContainer.snp.bottom).offset(Theme.Spacing.md)
            make.centerX.equalToSuperview()
        }

        let levelLabel = UILabel()
        levelLabel.font = Theme.Font.subhead()
        levelLabel.textColor = Theme.Colors.primary
        levelLabel.textAlignment = .center
        levelLabel.tag = 101
        contentView.addSubview(levelLabel)
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Theme.Spacing.sm)
            make.centerX.equalToSuperview()
        }
    }

    private func setupStats() {
        let statsContainer = UIView()
        statsContainer.backgroundColor = Theme.Colors.backgroundCard
        statsContainer.layer.cornerRadius = Theme.CornerRadius.large
        contentView.addSubview(statsContainer)
        statsContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Spacing.xl + 120)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }

        let statsStack = UIStackView()
        statsStack.axis = .horizontal
        statsStack.distribution = .fillEqually
        statsContainer.addSubview(statsStack)
        statsStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Theme.Spacing.lg)
        }

        let catsView = createStatView(value: "0", label: "Cats", icon: "cat.fill", color: Theme.Colors.primary)
        catsView.tag = 200
        let tasksView = createStatView(value: "0", label: "Tasks", icon: "checkmark.circle.fill", color: Theme.Colors.secondary)
        tasksView.tag = 201
        let streakView = createStatView(value: "0", label: "Streak", icon: "flame.fill", color: Theme.Colors.accent)
        streakView.tag = 202

        statsStack.addArrangedSubview(catsView)
        statsStack.addArrangedSubview(tasksView)
        statsStack.addArrangedSubview(streakView)
    }

    private func createStatView(value: String, label: String, icon: String, color: UIColor) -> UIView {
        let container = UIView()

        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = color
        iconView.contentMode = .scaleAspectFit
        container.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(24)
        }

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = Theme.Font.title2()
        valueLabel.textColor = Theme.Colors.textPrimary
        valueLabel.textAlignment = .center
        valueLabel.tag = 1
        container.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        let labelView = UILabel()
        labelView.text = label
        labelView.font = Theme.Font.caption()
        labelView.textColor = Theme.Colors.textMuted
        labelView.textAlignment = .center
        container.addSubview(labelView)
        labelView.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        return container
    }

    private func setupPremiumCard() {
        let premiumCard = UIView()
        premiumCard.backgroundColor = Theme.Colors.backgroundCard
        premiumCard.layer.cornerRadius = Theme.CornerRadius.large
        premiumCard.layer.borderWidth = 2
        premiumCard.layer.borderColor = Theme.Colors.primary.cgColor
        contentView.addSubview(premiumCard)
        premiumCard.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Spacing.xl + 240)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }

        let crownIcon = UIImageView(image: UIImage(systemName: "crown.fill"))
        crownIcon.tintColor = Theme.Colors.primary
        crownIcon.contentMode = .scaleAspectFit
        premiumCard.addSubview(crownIcon)
        crownIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.size.equalTo(24)
        }

        let premiumTitle = UILabel()
        premiumTitle.text = "Upgrade to Premium"
        premiumTitle.font = Theme.Font.headline()
        premiumTitle.textColor = Theme.Colors.primary
        premiumCard.addSubview(premiumTitle)
        premiumTitle.snp.makeConstraints { make in
            make.centerY.equalTo(crownIcon)
            make.leading.equalTo(crownIcon.snp.trailing).offset(Theme.Spacing.sm)
        }

        let premiumDesc = UILabel()
        premiumDesc.text = "Unlock AI Health Insights & Expert Vet Consultations"
        premiumDesc.font = Theme.Font.caption()
        premiumDesc.textColor = Theme.Colors.textSecondary
        premiumCard.addSubview(premiumDesc)
        premiumDesc.snp.makeConstraints { make in
            make.top.equalTo(premiumTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.bottom.equalToSuperview().offset(-Theme.Spacing.md)
        }
    }

    private func setupSettings() {
        let settingsLabel = UILabel()
        settingsLabel.text = "Settings"
        settingsLabel.font = Theme.Font.title3()
        settingsLabel.textColor = Theme.Colors.textPrimary
        contentView.addSubview(settingsLabel)
        settingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Spacing.xl + 340)
            make.leading.equalToSuperview().offset(Theme.Spacing.lg)
        }

        let settingsTable = UIStackView()
        settingsTable.axis = .vertical
        settingsTable.spacing = 0
        contentView.addSubview(settingsTable)
        settingsTable.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(Theme.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }

        let settingsItems = [
            ("bell.fill", "Notifications & Reminders"),
            ("heart.fill", "Health Records"),
            ("creditcard.fill", "Subscription & Billing"),
            ("lock.fill", "Privacy & Safety"),
            ("questionmark.circle.fill", "Help & Support"),
            ("info.circle.fill", "About")
        ]

        for (icon, title) in settingsItems {
            let row = createSettingsRow(icon: icon, title: title)
            settingsTable.addArrangedSubview(row)
        }

        settingsTable.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-Theme.Spacing.xl)
        }
    }

    private func createSettingsRow(icon: String, title: String) -> UIView {
        let row = UIView()
        row.backgroundColor = Theme.Colors.backgroundCard

        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = Theme.Colors.primary
        iconView.contentMode = .scaleAspectFit
        row.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
            make.size.equalTo(22)
        }

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = Theme.Font.body()
        titleLabel.textColor = Theme.Colors.textPrimary
        row.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
        }

        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = Theme.Colors.textMuted
        row.addSubview(chevron)
        chevron.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Theme.Spacing.md)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }

        row.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        return row
    }

    private func updateUI() {
        let profile = dbService.loadUserProfile()
        let cats = dbService.loadCats()

        if let nameLabel = contentView.viewWithTag(100) as? UILabel {
            nameLabel.text = profile.name.isEmpty ? "Cat Parent" : profile.name
        }
        if let levelLabel = contentView.viewWithTag(101) as? UILabel {
            levelLabel.text = "Level \(profile.level) • \(profile.xp) XP"
        }

        if let catsView = contentView.viewWithTag(200),
           let valueLabel = catsView.viewWithTag(1) as? UILabel {
            valueLabel.text = "\(cats.count)"
        }
        if let tasksView = contentView.viewWithTag(201),
           let valueLabel = tasksView.viewWithTag(1) as? UILabel {
            valueLabel.text = "\(profile.totalTasksCompleted)"
        }
        if let streakView = contentView.viewWithTag(202),
           let valueLabel = streakView.viewWithTag(1) as? UILabel {
            valueLabel.text = "\(profile.streakDays)"
        }
    }
}