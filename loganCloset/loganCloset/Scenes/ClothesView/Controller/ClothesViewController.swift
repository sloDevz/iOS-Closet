//
//  ClothesViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit
import SnapKit

final class ClothesViewController: UIViewController {

    // MARK: - Constant
    private typealias DataSource = UICollectionViewDiffableDataSource<ClothesCategory, Clothes>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<ClothesCategory, Clothes>

    private enum Constant {
        static let titleLabelText: String = "MY CLOTHES"
        static let titleLabelFontSize: CGFloat = 18

        static let filterIconImageName: String = "Filter"
        static let headerViewElementKind: String = "section-header"

        static let squareItemSize: CGFloat = 1.0
        static let groupHeightFractionalSize: CGFloat = 0.15
        static let headerWidthDimension: CGFloat = 1.0
        static let headerHeightEstimatedSize: CGFloat = 20
        static let sectionTopContentInset:CGFloat = 40.0
        static let sectionLeadingContentInset:CGFloat = 20.0
        static let sectionGroupSpacing:CGFloat = 20
    }

    // MARK: - Properties
    private var clothesManager: ClothesManager?
    private lazy var dataSource: DataSource = configureDataSource()

    // MARK: - UI Components
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.titleLabelText
        label.font = UIFont.importedUIFont(
            name: .pretendardExtraBold,
            fontSize: Constant.titleLabelFontSize
        )
        label.sizeToFit()

        return label
    }()
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constant.filterIconImageName), for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)

        return button
    }()
    private lazy var clothesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())

        return collectionView
    }()

    // MARK: - LifeCycle
    init(clothesManager: ClothesManager? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.clothesManager = clothesManager
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAppearance()
        setNavigationBarItems()
        setCollectionView()
        configureCollectionViewLayoutConstraint()
        applySnapShot(animation: false)

    }

    // MARK: - Private
    private func setViewAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        view.backgroundColor = .systemBackground
    }

    private func setNavigationBarItems() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalHeight(Constant.squareItemSize),
                heightDimension: .fractionalHeight(Constant.squareItemSize)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupFractionalHeight = Constant.groupHeightFractionalSize
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalHeight(groupFractionalHeight),
                heightDimension: .fractionalHeight(groupFractionalHeight))

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Constant.headerWidthDimension),
                heightDimension: .estimated(Constant.headerHeightEstimatedSize)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: Constant.headerViewElementKind,
                alignment: .top
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(
                top: Constant.sectionTopContentInset,
                leading: Constant.sectionLeadingContentInset,
                bottom: .zero,
                trailing: .zero
            )
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = Constant.sectionGroupSpacing

            return section
        }
        return layout
    }

    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: clothesCollectionView)  { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ClothesItemCell.reuseidentifier,
                for: indexPath) as? ClothesItemCell
            cell?.configureContent(with: item)
            return cell
        }

        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in

            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: ClothesHeaderView.reuseableIdentifier,
                for: indexPath) as? ClothesHeaderView else
            {
                fatalError("Cannot create header view")
            }

            let sections = ClothesCategory.allCases
            supplementaryView.titleLabel.text = sections[indexPath.section + 1].rawValue

            return supplementaryView
        }
        return dataSource
    }

    private func setCollectionView() {
        clothesCollectionView.backgroundColor = .systemBackground
        clothesCollectionView.delegate = self
        clothesCollectionView.register(
            ClothesItemCell.self,
            forCellWithReuseIdentifier: ClothesItemCell.reuseidentifier
        )
        clothesCollectionView.register(
            ClothesHeaderView.self,
            forSupplementaryViewOfKind: Constant.headerViewElementKind,
            withReuseIdentifier: ClothesHeaderView.reuseableIdentifier
        )
    }

    private func configureCollectionViewLayoutConstraint() {
        view.addSubview(clothesCollectionView)
        clothesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func applySnapShot(animation: Bool) {
        guard let clothesManager else { return }
        let allClothes = clothesManager.fetchCloset()

        var snapShot = SnapShot()

        let allCategories = ClothesCategory.allCases
        allCategories.forEach { category in
            if category != .none {
                let itemForAddButton = Clothes(
                    itemImage: UIImage(systemName: "plus")!,
                    clothesCategory: .none,
                    season: .all
                )
                let items = allClothes.filter { clothes in
                    clothes.clothesCategory == category
                }
                snapShot.appendSections([category])
                snapShot.appendItems([itemForAddButton] + items)
            }
        }
        dataSource.apply(snapShot, animatingDifferences: animation)
    }

    @objc
    private func filterButtonTapped() {
        print(#function)
    }

}

extension ClothesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.item == .zero {
            let addClothesVC = AddClothesViewController()
            addClothesVC.delegate = self
            addClothesVC.modalPresentationStyle = .fullScreen
            present(addClothesVC, animated: true)
        }
    }

}

extension ClothesViewController: ClothesDataProtocol {

    func updateClothesData(data: Clothes?) {
        guard let data else { return }
        clothesManager?.addClothes(clothes: data)
        applySnapShot(animation: true)
    }

}
