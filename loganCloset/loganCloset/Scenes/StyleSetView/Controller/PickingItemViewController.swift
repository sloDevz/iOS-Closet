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
    var selectedCellIndexPath: IndexPath?

    // MARK: - UI Components
    private let emptyGuideView = TextOnlyView(text: "아이템이 없습니다. \n아이템을 등록하세요")
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
        view.addSubview(categorizedCollectionView)
        view.addSubview(buttonsContainer)
        view.addSubview(emptyGuideView)
        buttonsContainer.addSubview(doneButton)
        buttonsContainer.addSubview(closeButton)
        buttonsContainer.addSubview(buttonsSeperator)

        categorizedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(buttonsContainer.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

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

        emptyGuideView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(buttonsContainer.snp.bottom)
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

    private func applySnapShot(animation: Bool) {

        guard let category,
              let closet = clothesManager?.fetchCloset() else { return }

        let filteredItems = closet.filter { item in
            item.clothesCategory == category
        }

        filteredItems.isEmpty ? (emptyGuideView.isHidden = false) : (emptyGuideView.isHidden = true)

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

        if let selectedCellIndexPath,
           let preSelectedCell = collectionView.cellForItem(at: selectedCellIndexPath) as? StyleItemCell {
            preSelectedCell.toggleSelectiedSign()
            preSelectedCell.layer.cornerRadius = 16
            preSelectedCell.layer.borderWidth = 0
            preSelectedCell.layer.borderColor = UIColor.clear.cgColor
            UIView.animate(withDuration: 0.1) {
                preSelectedCell.transform = CGAffineTransform.identity

            }
        }

        if selectedCellIndexPath == indexPath {
            selectedItem = nil
            selectedCellIndexPath = nil
            return
        }

        if let selectedCell = collectionView.cellForItem(at: indexPath) as? StyleItemCell {
            selectedCell.toggleSelectiedSign()
            selectedCell.layer.cornerRadius = 16
            selectedCell.layer.borderWidth = 5
            selectedCell.layer.borderColor = UIColor.separator.cgColor
            UIView.animate(withDuration: 0.1) {
                selectedCell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
            selectedCellIndexPath = indexPath
        }
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
