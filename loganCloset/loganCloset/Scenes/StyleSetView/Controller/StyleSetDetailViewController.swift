//
//  StyleSetDetailViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/26.
//

import UIKit
import SnapKit

final class StyleSetDetailViewController: UIViewController {

    // MARK: - Constants
    private typealias DataSource = UICollectionViewDiffableDataSource<StyleSetCategory, Clothes>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<StyleSetCategory, Clothes>

    enum Constants {
        static let itemFractionalWidthHeight: CGFloat = 1
        static let contentInsetForClothes: CGFloat = 2

        static let groupWidthSizeForWidthHeightDimension: CGFloat = 1/3
        static let sectionEdgeInset: CGFloat = 2

        static let itemWidthDimensionForAccessory: CGFloat = 1/4
        static let itemHeightDimensionForAccessory: CGFloat = 1
        static let contentInsetForAccessory: CGFloat = 8

        static let groupWidthDimension: CGFloat = 1
        static let groupHeightDimension: CGFloat = 1/4
    }

    // MARK: - Properties
    private var styleSet: StyleSet?
    private lazy var dataSource: DataSource = configureDataSource()
    private var shouldSwapItem = true

    // MARK: - UI Components
    private lazy var  styleDetailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())

        return collectionView
    }()


    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setHierarchy()
        setCollectionView()
        configureCollectionViewLayoutConstraint()
        applySnapShot(animation: false)
    }

    init(styleSet: StyleSet? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.styleSet = styleSet
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }

    private func setHierarchy() {
        view.addSubview(styleDetailCollectionView)
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let sectionLayoutKind = StyleSetCategory.allCases[section]
            switch sectionLayoutKind {
            case.accessory:
                return self.generateLayoutForAccessory()
            default:
                return self.generateLayoutForClothes()
            }
        }
        return layout
    }

    private func generateLayoutForClothes() -> NSCollectionLayoutSection {
        let inset = Constants.contentInsetForClothes
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.itemFractionalWidthHeight),
            heightDimension: .fractionalHeight(Constants.itemFractionalWidthHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: inset,
            leading: inset,
            bottom: inset,
            trailing: inset
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.groupWidthSizeForWidthHeightDimension),
            heightDimension: .fractionalWidth(Constants.groupWidthSizeForWidthHeightDimension)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: inset,
            leading: inset,
            bottom: inset,
            trailing: inset
        )
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }

    private func generateLayoutForAccessory() -> NSCollectionLayoutSection {
        let inset = Constants.contentInsetForAccessory
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.itemWidthDimensionForAccessory),
            heightDimension: .fractionalHeight(Constants.itemHeightDimensionForAccessory)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.groupWidthDimension),
            heightDimension: .fractionalWidth(Constants.groupHeightDimension)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item, item, item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        return section
    }
    

    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: styleDetailCollectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StyleItemCell.reuseidentifier,
                for: indexPath) as? StyleItemCell

            cell?.configureContent(with: item)
            return cell
        }
        return dataSource
    }

    private func setCollectionView() {
        styleDetailCollectionView.backgroundColor = .systemBackground
        styleDetailCollectionView.delegate = self
        styleDetailCollectionView.register(
            StyleItemCell.self,
            forCellWithReuseIdentifier: StyleItemCell.reuseidentifier
        )
    }

    private func configureCollectionViewLayoutConstraint() {
        styleDetailCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func applySnapShot(animation: Bool) {
        guard let styleSet else { return }
        var snapShot = SnapShot()

        let sections = StyleSetCategory.allCases
        let items = styleSet.items

        sections.forEach { section in
            let categorizedItem = items.filter { item in
                item.styleSetCategory == section
            }
            snapShot.appendSections([section])
            snapShot.appendItems(categorizedItem)
        }
        dataSource.apply(snapShot)
    }

    private func applySnapShotWithBodyItemsSwapping (animation: Bool) {
        guard let styleSet else { return }
        var snapShot = SnapShot()

        let sections = StyleSetCategory.allCases
        let items = styleSet.items

        sections.forEach { section in
            var categorizedItem = items.filter { item in
                item.styleSetCategory == section
            }
            if section == .body && categorizedItem.count > 1 {
                if shouldSwapItem {
                    let firstBodyItem = categorizedItem[0]
                    categorizedItem[0] = categorizedItem[1]
                    categorizedItem[1] = firstBodyItem
                }
            }
            snapShot.appendSections([section])
            snapShot.appendItems(categorizedItem)
        }
        dataSource.apply(snapShot)
    }

}

extension StyleSetDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSection = StyleSetCategory.allCases[indexPath.section]
        if selectedSection == StyleSetCategory.body {
            applySnapShotWithBodyItemsSwapping(animation: true)
            shouldSwapItem.toggle()
        }
    }
}

#if DEBUG
import SwiftUI
struct DetailStyleViewController_Previews: PreviewProvider {
    static var previews: some View { Container().edgesIgnoringSafeArea(.all) }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return StyleSetDetailViewController(
                styleSet: ClothesManager().fetchStyleSets()[0]
            )
        }
        func updateUIViewController(_ uiViewController: UIViewController,context: Context) { }
    }
}
#endif
