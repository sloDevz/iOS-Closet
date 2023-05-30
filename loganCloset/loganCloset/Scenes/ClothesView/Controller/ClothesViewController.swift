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
        static let headerViewElementKind: String = "section-header"
    }

    // MARK: - Properties
    private var clothesManager: ClothesManager?
    private lazy var dataSource: DataSource = configureDataSource()

    // MARK: - UI Components
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MY CLOTHES"
        label.font = UIFont.importedUIFont(
            name: .pretendardExtraBold,
            fontSize: 18
        )
        label.sizeToFit()

        return label
    }()
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Filter"), for: .normal)
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

        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }

    private func setNavigationBarItems() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalHeight(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupFractionalHeight = 0.15
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalHeight(groupFractionalHeight),
                heightDimension: .fractionalHeight(groupFractionalHeight))

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(20)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: Constant.headerViewElementKind,
                alignment: .top
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(
                top: 40,
                leading: 20,
                bottom: .zero,
                trailing: .zero
            )
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 20

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
        clothesCollectionView.register(ClothesItemCell.self,
                                       forCellWithReuseIdentifier: ClothesItemCell.reuseidentifier
        )
        clothesCollectionView.register(ClothesHeaderView.self,
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

        let hats = allClothes.filter({ clothes in
            clothes.clothesCategory == .hat
        })
            snapShot.appendSections([ClothesCategory.hat])
            snapShot.appendItems([Clothes(itemImage: UIImage(systemName: "plus")!, clothesCategory: .none, season: .all)] + hats)

        let outers = allClothes.filter({ clothes in
            clothes.clothesCategory == .outer
        })
            snapShot.appendSections([ClothesCategory.outer])
            snapShot.appendItems([Clothes(itemImage: UIImage(systemName: "plus")!, clothesCategory: .none, season: .all)] + outers)

        let tops = allClothes.filter({ clothes in
            clothes.clothesCategory == .top
        })
            snapShot.appendSections([ClothesCategory.top])
            snapShot.appendItems([Clothes(itemImage: UIImage(systemName: "plus")!, clothesCategory: .none, season: .all)] + tops)

        let bottoms = allClothes.filter({ clothes in
            clothes.clothesCategory == .bottom
        })
            snapShot.appendSections([ClothesCategory.bottom])
            snapShot.appendItems([Clothes(itemImage: UIImage(systemName: "plus")!, clothesCategory: .none, season: .all)] + bottoms)

        let shoes = allClothes.filter({ clothes in
            clothes.clothesCategory == .footWaer
        })
            snapShot.appendSections([ClothesCategory.footWaer])
            snapShot.appendItems([Clothes(itemImage: UIImage(systemName: "plus")!, clothesCategory: .none, season: .all)] + shoes)

        let accessories = allClothes.filter({ clothes in
            clothes.clothesCategory == .accessory
        })
            snapShot.appendSections([ClothesCategory.accessory])
            snapShot.appendItems([Clothes(itemImage: UIImage(systemName: "plus")!,clothesCategory: .none, season: .all)] + accessories)


        dataSource.apply(snapShot, animatingDifferences: animation)
    }

    @objc
    private func filterButtonTapped() {
        print(#function)
    }

}

extension ClothesViewController: UICollectionViewDelegate {

}

