//
//  DetailStyleViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/26.
//

import UIKit
import SnapKit

final class DetailStyleViewController: UIViewController {

    // MARK: - Constants
    private typealias DataSource = UICollectionViewDiffableDataSource<StyleSetCategory, Clothes>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<StyleSetCategory, Clothes>

    // MARK: - Properties
    private var styleSet: StyleSet?
    private lazy var dataSource: DataSource = configureDataSource()

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

//        guard let styleSet,
//              let back = styleSet.backgroundImage else { return }
//        styleDetailCollectionView.backgroundView = UIImageView(image: back)

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
        let inset = CGFloat(2)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalWidth(1/3)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }

    private func generateLayoutForAccessory() -> NSCollectionLayoutSection {
        let inset = CGFloat(8)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/4),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/4)
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

}

extension DetailStyleViewController: UICollectionViewDelegate {

}

#if DEBUG
import SwiftUI
struct DetailStyleViewController_Previews: PreviewProvider {
    static var previews: some View { Container().edgesIgnoringSafeArea(.all) }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return DetailStyleViewController(
                styleSet: ClothesManager().fetchStyleSets()[0]
            )
        }
        func updateUIViewController(_ uiViewController: UIViewController,context: Context) { }
    }
}
#endif
