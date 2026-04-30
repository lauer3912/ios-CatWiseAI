import UIKit
import SnapKit

class LearnViewController: UIViewController {

    private let categories: [ArticleCategory] = [.behavior, .health, .nutrition, .training]

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = Theme.Colors.backgroundDark
        title = "Learn"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupScrollView()
        setupSearchBar()
        setupFeaturedArticle()
        setupCategories()
        setupDailyTip()
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

    private func setupSearchBar() {
        searchBar.placeholder = "Search articles..."
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = Theme.Colors.primary
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.md)
        }
    }

    private func setupFeaturedArticle() {
        let featuredCard = UIView()
        featuredCard.backgroundColor = Theme.Colors.backgroundCard
        featuredCard.layer.cornerRadius = Theme.CornerRadius.large
        featuredCard.layer.borderWidth = 1
        featuredCard.layer.borderColor = Theme.Colors.primary.withAlphaComponent(0.3).cgColor
        contentView.addSubview(featuredCard)
        featuredCard.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(Theme.Spacing.lg)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }

        let featuredLabel = UILabel()
        featuredLabel.text = "FEATURED"
        featuredLabel.font = Theme.Font.caption()
        featuredLabel.textColor = Theme.Colors.primary
        featuredCard.addSubview(featuredLabel)
        featuredLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Theme.Spacing.md)
        }

        let titleLabel = UILabel()
        titleLabel.text = "Understanding Cat Body Language"
        titleLabel.font = Theme.Font.title3()
        titleLabel.textColor = Theme.Colors.textPrimary
        titleLabel.numberOfLines = 2
        featuredCard.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(featuredLabel.snp.bottom).offset(Theme.Spacing.sm)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.md)
        }

        let readMore = UILabel()
        readMore.text = "Learn to read your cat's moods →"
        readMore.font = Theme.Font.caption()
        readMore.textColor = Theme.Colors.primary
        featuredCard.addSubview(readMore)
        readMore.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Theme.Spacing.sm)
            make.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.bottom.equalToSuperview().offset(-Theme.Spacing.md)
        }
    }

    private func setupCategories() {
        let categoriesLabel = UILabel()
        categoriesLabel.text = "Categories"
        categoriesLabel.font = Theme.Font.title3()
        categoriesLabel.textColor = Theme.Colors.textPrimary
        contentView.addSubview(categoriesLabel)
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(Theme.Spacing.xl + 120)
            make.leading.equalToSuperview().offset(Theme.Spacing.lg)
        }

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Theme.Spacing.md
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(categoriesLabel.snp.bottom).offset(Theme.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
        }

        for category in categories {
            let card = createCategoryCard(category)
            stackView.addArrangedSubview(card)
        }
    }

    private func createCategoryCard(_ category: ArticleCategory) -> UIView {
        let card = UIView()
        card.backgroundColor = Theme.Colors.backgroundCard
        card.layer.cornerRadius = Theme.CornerRadius.medium

        let iconView = UIImageView(image: UIImage(systemName: category.icon))
        iconView.tintColor = UIColor(hex: category.color)
        iconView.contentMode = .scaleAspectFit
        card.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
            make.size.equalTo(28)
        }

        let titleLabel = UILabel()
        titleLabel.text = category.rawValue
        titleLabel.font = Theme.Font.headline()
        titleLabel.textColor = Theme.Colors.textPrimary
        card.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(Theme.Spacing.md)
            make.centerY.equalToSuperview()
        }

        let articleCount = UILabel()
        articleCount.text = ["25", "15", "12", "20"][categories.firstIndex(of: category)!] + " articles"
        articleCount.font = Theme.Font.caption()
        articleCount.textColor = Theme.Colors.textMuted
        card.addSubview(articleCount)
        articleCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Theme.Spacing.md)
            make.centerY.equalToSuperview()
        }

        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = Theme.Colors.textMuted
        card.addSubview(chevron)
        chevron.snp.makeConstraints { make in
            make.trailing.equalTo(articleCount.snp.leading).offset(-Theme.Spacing.sm)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }

        card.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        return card
    }

    private func setupDailyTip() {
        let tipCard = UIView()
        tipCard.backgroundColor = Theme.Colors.primary.withAlphaComponent(0.15)
        tipCard.layer.cornerRadius = Theme.CornerRadius.medium
        tipCard.layer.borderWidth = 1
        tipCard.layer.borderColor = Theme.Colors.primary.withAlphaComponent(0.3).cgColor
        contentView.addSubview(tipCard)
        tipCard.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(Theme.Spacing.xl + 320)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.lg)
            make.bottom.equalToSuperview().offset(-Theme.Spacing.lg)
        }

        let tipIcon = UIImageView(image: UIImage(systemName: "lightbulb.fill"))
        tipIcon.tintColor = Theme.Colors.primary
        tipCard.addSubview(tipIcon)
        tipIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Theme.Spacing.md)
            make.size.equalTo(20)
        }

        let tipTitle = UILabel()
        tipTitle.text = "Today's Tip"
        tipTitle.font = Theme.Font.headline()
        tipTitle.textColor = Theme.Colors.primary
        tipCard.addSubview(tipTitle)
        tipTitle.snp.makeConstraints { make in
            make.centerY.equalTo(tipIcon)
            make.leading.equalTo(tipIcon.snp.trailing).offset(Theme.Spacing.sm)
        }

        let tipText = UILabel()
        tipText.text = "Cats communicate through slow blinks - try blinking at your cat! It's a sign of trust and affection."
        tipText.font = Theme.Font.body()
        tipText.textColor = Theme.Colors.textSecondary
        tipText.numberOfLines = 0
        tipCard.addSubview(tipText)
        tipText.snp.makeConstraints { make in
            make.top.equalTo(tipIcon.snp.bottom).offset(Theme.Spacing.sm)
            make.leading.trailing.equalToSuperview().inset(Theme.Spacing.md)
            make.bottom.equalToSuperview().offset(-Theme.Spacing.md)
        }
    }
}