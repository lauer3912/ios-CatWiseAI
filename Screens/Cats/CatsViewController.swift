import UIKit
import SnapKit

class CatsViewController: UIViewController {

    private let dbService = DatabaseService.shared
    private var cats: [Cat] = []

    private let tableView = UITableView()
    private let emptyStateView = UIView()

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
        title = "My Cats"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCatTapped))
        addButton.tintColor = Theme.Colors.primary
        navigationItem.rightBarButtonItem = addButton

        setupTableView()
        setupEmptyState()
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatCell.self, forCellReuseIdentifier: "CatCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupEmptyState() {
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        let iconView = UIImageView(image: UIImage(systemName: "cat.fill"))
        iconView.tintColor = Theme.Colors.textMuted
        iconView.contentMode = .scaleAspectFit
        emptyStateView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(60)
        }

        let label = UILabel()
        label.text = "No cats yet"
        label.font = Theme.Font.title3()
        label.textColor = Theme.Colors.textSecondary
        emptyStateView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(Theme.Spacing.md)
            make.centerX.equalToSuperview()
        }

        let addLabel = UILabel()
        addLabel.text = "Tap + to add your first cat"
        addLabel.font = Theme.Font.subhead()
        addLabel.textColor = Theme.Colors.textMuted
        emptyStateView.addSubview(addLabel)
        addLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(Theme.Spacing.sm)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func loadData() {
        cats = dbService.loadCats()
        tableView.reloadData()
        emptyStateView.isHidden = !cats.isEmpty
        tableView.isHidden = cats.isEmpty
    }

    @objc private func addCatTapped() {
        let alert = UIAlertController(title: "Add New Cat", message: "Enter cat details", preferredStyle: .alert)
        alert.addTextField { tf in tf.placeholder = "Name (e.g., Luna)" }
        alert.addTextField { tf in tf.placeholder = "Breed (e.g., British Shorthair)" }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let name = alert.textFields?[0].text, !name.isEmpty,
                  let breed = alert.textFields?[1].text, !breed.isEmpty else { return }
            let cat = Cat(name: name, breed: breed, birthDate: Date(), healthScore: 75)
            self?.dbService.addCat(cat)
            self?.loadData()
        })
        present(alert, animated: true)
    }
}

extension CatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatCell
        cell.cat = cats[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class CatCell: UITableViewCell {
    var cat: Cat? {
        didSet {
            nameLabel.text = cat?.name
            breedLabel.text = cat?.breed
            healthLabel.text = "Health: \(cat?.healthScore ?? 0)/100"
        }
    }

    private let containerView = UIView()
    private let avatarView = UIView()
    private let nameLabel = UILabel()
    private let breedLabel = UILabel()
    private let healthLabel = UILabel()
    private let speciesIcon = UIImageView()

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
        containerView.layer.cornerRadius = Theme.CornerRadius.large
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }

        avatarView.backgroundColor = Theme.Colors.primary.withAlphaComponent(0.2)
        avatarView.layer.cornerRadius = 35
        avatarView.layer.borderWidth = 2
        avatarView.layer.borderColor = Theme.Colors.primary.cgColor
        containerView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
            make.size.equalTo(70)
        }

        speciesIcon.image = UIImage(systemName: "cat.fill")
        speciesIcon.tintColor = Theme.Colors.primary
        speciesIcon.contentMode = .scaleAspectFit
        avatarView.addSubview(speciesIcon)
        speciesIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(30)
        }

        nameLabel.font = Theme.Font.title3()
        nameLabel.textColor = Theme.Colors.textPrimary
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Spacing.lg)
            make.leading.equalTo(avatarView.snp.trailing).offset(Theme.Spacing.md)
        }

        breedLabel.font = Theme.Font.subhead()
        breedLabel.textColor = Theme.Colors.textSecondary
        containerView.addSubview(breedLabel)
        breedLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }

        healthLabel.font = Theme.Font.caption()
        healthLabel.textColor = Theme.Colors.success
        containerView.addSubview(healthLabel)
        healthLabel.snp.makeConstraints { make in
            make.top.equalTo(breedLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }
    }
}