//
//  PickingItemViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/28.
//

import UIKit
import SnapKit

final class PickingItemViewController: UIViewController {

    enum Section {
        case main
    }

    // MARK: - Constants
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Clothes>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Clothes>

    // MARK: - Properties
    var delegate: ClothesDataProtocol?
    var category: ClothesCategory?
    var clothesManager: ClothesManager?
    private lazy var dataSource: DataSource = configureDataSource()
    var selectedItem: Clothes?

    // MARK: - UI Components
    private let buttonsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    private let buttonsSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.importedUIFont(name: .pretendardSemiBold, fontSize: 18)
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.importedUIFont(name: .pretendardSemiBold, fontSize: 18)
        button.setTitle("선택", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var categorizedCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())

        return collectionView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUILayout()
        setCollectionView()
        applySnapShot(animation: false)
        configureCollectionViewLayoutConstraint()
    }

    init(category: ClothesCategory? = nil, clothesManager: ClothesManager) {
        super.init(nibName: nil, bundle: nil)
        self.clothesManager = clothesManager
        self.category = category
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public

    // MARK: - Private

    private func setupUILayout() {
        view.addSubview(buttonsContainer)
        buttonsContainer.addSubview(doneButton)
        buttonsContainer.addSubview(closeButton)
        buttonsContainer.addSubview(buttonsSeperator)

        buttonsContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }

        doneButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(25)
        }

        closeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(25)
        }

        buttonsSeperator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: categorizedCollectionView)  { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StyleItemCell.reuseidentifier,
                for: indexPath) as? StyleItemCell
            cell?.configureContent(with: item)
            return cell
        }
        return dataSource
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let inset = CGFloat(8)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1/3))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            return section
        }
        return layout
    }

    private func setCollectionView() {
        categorizedCollectionView.backgroundColor = .systemBackground
        categorizedCollectionView.delegate = self
        categorizedCollectionView.register(StyleItemCell.self,
                                           forCellWithReuseIdentifier: StyleItemCell.reuseidentifier
        )
    }

    private func configureCollectionViewLayoutConstraint() {
        view.addSubview(categorizedCollectionView)
        categorizedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(buttonsContainer.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func applySnapShot(animation: Bool) {

        guard let category,
              let closet = clothesManager?.closet else { return }

        let filteredItems = closet.filter { item in
            item.clothesCategory == category
        }

        var snapShot = SnapShot()

        snapShot.appendSections([Section.main])
        snapShot.appendItems(filteredItems)

        dataSource.apply(snapShot, animatingDifferences: animation)
    }

    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }

    @objc
    private func doneButtonTapped() {
        guard let selectedItem else { return }
        delegate?.updateClothesData(data: selectedItem)
        dismiss(animated: true)
    }


}

extension PickingItemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        selectedItem = item
    }
}


#if DEBUG
import SwiftUI
struct PickingItemViewController_Previews: PreviewProvider {
    static var previews: some View { Container().edgesIgnoringSafeArea(.all) }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController { return PickingItemViewController(category: .footWaer,clothesManager: ClothesManager()) }
        func updateUIViewController(_ uiViewController: UIViewController,context: Context) { }
    }
}
#endif
