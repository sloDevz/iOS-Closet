//
//  StyleSetViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit
import SnapKit

final class StyleSetViewController: UIViewController {

    enum Section {
        case main
    }
    // MARK: - Constants
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, StyleSet>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, StyleSet>

    enum Constants {
        static let titleLabelText: String = "MY STYLE"
        static let titleLabelFontSize: CGFloat = 18
        static let emptyViewGreetingText:String = "등록된 코디가 없습니다."
        static let addStyleButtonImageName: String = "Add_StyleSet_icon"

        static let itemFractionalwidth: CGFloat = 0.5
        static let itemFractionalHeight: CGFloat = 1
        static let itemLeadingTrailingInset: CGFloat = 4

        static let groupFractionalWidth: CGFloat = 1
        static let groupFractionalWidthForHeight: CGFloat = 0.75

        static let groupTopInset: CGFloat = 16
        static let groupLeadingTrailingInset: CGFloat = 20
    }

    // MARK: - Properties
    private var clothesManager: ClothesManager
    private lazy var dataSource: DataSource = configureDataSource()
    private lazy var myStyleCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        return collectionView
    }()

    // MARK: - UI Components
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleLabelText
        label.font = UIFont.importedUIFont(
            name: .pretendardExtraBold,
            fontSize: Constants.titleLabelFontSize
        )
        return label
    }()
    private let emptyStyleSetGuideView = EmptyViewGuide(text: Constants.emptyViewGreetingText)
    private lazy var addStyleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(
            named: Constants.addStyleButtonImageName),for: .normal
        )
        button.addTarget(self, action: #selector(addStyleButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle
    init(clothesManager: ClothesManager) {
        self.clothesManager = clothesManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        applySnapShot(animation: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAppearance()
        setNavigationBarItems()
        setCollectionView()
        configureCollectionViewLayoutConstraint()
        applySnapShot(animation: false)
    }

    // MARK: - Methodes
    private func setViewAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }

    private func setNavigationBarItems() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: addStyleButton)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }

    private func setCollectionView() {
        myStyleCollectionView.backgroundColor = .systemBackground
        myStyleCollectionView.delegate = self
        myStyleCollectionView.register(StyleSetCell.self, forCellWithReuseIdentifier: StyleSetCell.reuseidentifier)
    }

    private func configureCollectionViewLayoutConstraint() {
        view.addSubview(myStyleCollectionView)
        view.addSubview(emptyStyleSetGuideView)
        myStyleCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyStyleSetGuideView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Constants.itemFractionalwidth),
                heightDimension: .fractionalHeight(Constants.itemFractionalHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(
                top: .zero,
                leading: Constants.itemLeadingTrailingInset,
                bottom: .zero,
                trailing: Constants.itemLeadingTrailingInset
            )

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Constants.groupFractionalWidth),
                heightDimension: .fractionalWidth(Constants.groupFractionalWidthForHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item, item]
            )
            group.contentInsets = .init(
                top: Constants.groupTopInset,
                leading: Constants.groupLeadingTrailingInset,
                bottom: .zero,
                trailing: Constants.groupLeadingTrailingInset
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layout
    }

    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: myStyleCollectionView)  { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StyleSetCell.reuseidentifier,
                for: indexPath) as? StyleSetCell
            cell?.configureItemImage(with: item)
            return cell
        }
        return dataSource
    }

    private func applySnapShot(animation: Bool) {
        var snapShot = SnapShot()
        let styles = clothesManager.fetchStyleSets()

        styles.isEmpty ? (emptyStyleSetGuideView.isHidden = false) : (emptyStyleSetGuideView.isHidden = true)

        snapShot.appendSections([Section.main])
        snapShot.appendItems(styles)
        dataSource.apply(snapShot, animatingDifferences: animation)
    }

    @objc
    private func addStyleButtonTapped() {
        let vc = AddStyleSetViewController(clotheManager: clothesManager)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StyleSetViewController: StyleSetDataProtocol {

    func updateStyleSetData(data: StyleSet?) {
        guard let data else { return }
        clothesManager.add(styleSet: data)
        applySnapShot(animation: true)
    }

}

extension StyleSetViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let styleSet = dataSource.itemIdentifier(for: indexPath) else { return }
        navigationController?.pushViewController(
            StyleSetDetailViewController(styleSet: styleSet, clothesManager: clothesManager),
            animated: true
        )
    }

}
