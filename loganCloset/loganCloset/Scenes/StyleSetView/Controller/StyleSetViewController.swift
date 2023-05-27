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

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, StyleSet>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, StyleSet>

    //MARK: - Properties
    private var clothesManager: ClothesManager?
    private lazy var dataSource: DataSource = configureDataSource()
    private lazy var myStyleCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        return collectionView
    }()

    //MARK: - UI Components
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MY STYLE"
        label.font = UIFont.importedUIFont(name: .pretendardExtraBold,fontSize: 18)
        return label
    }()
    private let emptyStyleSetView = EmptyStyleSetView()
    private lazy var addStyleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Add_StyleSet_icon"), for: .normal)
        button.addTarget(self, action: #selector(addStyleButtonTapped), for: .touchUpInside)
        return button
    }()

    //MARK: - LifeCycle
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

    //MARK: - Methodes
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
    }

    private func setCollectionView() {
        myStyleCollectionView.backgroundColor = .systemBackground
        myStyleCollectionView.delegate = self
        myStyleCollectionView.register(StyleSetCell.self, forCellWithReuseIdentifier: StyleSetCell.reuseidentifier)
    }

    private func configureCollectionViewLayoutConstraint() {
        view.addSubview(myStyleCollectionView)
        view.addSubview(emptyStyleSetView)
        myStyleCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyStyleSetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.75))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
            group.contentInsets = .init(top: 16, leading: 20, bottom: 0, trailing: 20)

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
        guard let styles = clothesManager?.dummyStyleSets else { return }

        styles.isEmpty ? (emptyStyleSetView.isHidden = false) : (emptyStyleSetView.isHidden = true)

        snapShot.appendSections([Section.main])
        snapShot.appendItems(styles)
        dataSource.apply(snapShot, animatingDifferences: animation)
    }

    @objc
    private func addStyleButtonTapped() {
        navigationController?.pushViewController(
            StyleDetailViewController(),
            animated: true
        )
    }
}

extension StyleSetViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let styleSet = dataSource.itemIdentifier(for: indexPath) else { return }
        navigationController?.pushViewController(
            StyleDetailViewController(styleSet: styleSet),
            animated: true
        )
    }

}
