import UIKit
import SnapKit

class TasksViewController: UIViewController {

    private let dbService = DatabaseService.shared
    private var tasks: [CareTask] = []

    private let tableView = UITableView()
    private let headerView = UIView()
    private let dateLabel = UILabel()
    private let streakLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    private func setupUI() {
        view.backgroundColor = Theme.Colors.backgroundDark
        title = "Care Schedule"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupHeader()
        setupTableView()
    }

    private func setupHeader() {
        headerView.backgroundColor = Theme.Colors.backgroundCard
        headerView.layer.cornerRadius = Theme.CornerRadius.large
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Theme.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }

        let calendarIcon = UIImageView(image: UIImage(systemName: "calendar"))
        calendarIcon.tintColor = Theme.Colors.primary
        headerView.addSubview(calendarIcon)
        calendarIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        dateLabel.font = Theme.Font.headline()
        dateLabel.textColor = Theme.Colors.textPrimary
        headerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(calendarIcon.snp.trailing).offset(Theme.Spacing.sm)
            make.centerY.equalToSuperview()
        }

        streakLabel.font = Theme.Font.subhead()
        streakLabel.textColor = Theme.Colors.accent
        streakLabel.tag = 100
        headerView.addSubview(streakLabel)
        streakLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Theme.Spacing.md)
            make.centerY.equalToSuperview()
        }

        headerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(Theme.Spacing.md)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func loadData() {
        tasks = dbService.loadTasks()

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        dateLabel.text = formatter.string(from: Date())

        let profile = dbService.loadUserProfile()
        if let streak = headerView.viewWithTag(100) as? UILabel {
            streak.text = "🔥 \(profile.streakDays) day streak"
        }

        tableView.reloadData()
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.task = tasks[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        if !task.isCompleted {
            dbService.completeTask(id: task.id)
            loadData()
        }
    }
}

class TaskCell: UITableViewCell {
    var task: CareTask? {
        didSet {
            titleLabel.text = task?.title
            categoryLabel.text = task?.category.rawValue
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            timeLabel.text = formatter.string(from: task?.scheduledTime ?? Date())
            checkButton.isSelected = task?.isCompleted ?? false
        }
    }

    private let containerView = UIView()
    private let checkButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let timeLabel = UILabel()
    private let iconView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        containerView.backgroundColor = Theme.Colors.backgroundCard
        containerView.layer.cornerRadius = Theme.CornerRadius.medium
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
        }

        iconView.contentMode = .scaleAspectFit
        containerView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        titleLabel.font = Theme.Font.body()
        titleLabel.textColor = Theme.Colors.textPrimary
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Spacing.md)
            make.leading.equalTo(iconView.snp.trailing).offset(Theme.Spacing.md)
        }

        categoryLabel.font = Theme.Font.caption()
        categoryLabel.textColor = Theme.Colors.textSecondary
        containerView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(titleLabel)
        }

        timeLabel.font = Theme.Font.caption()
        timeLabel.textColor = Theme.Colors.textMuted
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Theme.Spacing.md)
            make.centerY.equalToSuperview()
        }
    }
}