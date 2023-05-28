//
//  StyleDetailViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/26.
//

import UIKit
import SnapKit

final class StyleDetailViewController: UIViewController {

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
    }

    private func setHierarchy() {
        view.addSubview(styleDetailCollectionView)
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalHeight(1.0),
                heightDimension: .fractionalWidth(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalWidth(1/3)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }

        return layout
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

        let sections = StyleSetCategory.allCases.dropLast()
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

extension StyleDetailViewController: UICollectionViewDelegate {

}

#if DEBUG
import SwiftUI
struct StyleDetailViewController_Previews: PreviewProvider {
    static var previews: some View { Container().edgesIgnoringSafeArea(.all) }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return StyleDetailViewController(
                styleSet: ClothesManager().dummyStyleSets[0]
            )
        }
        func updateUIViewController(_ uiViewController: UIViewController,context: Context) { }
    }
}
#endif
