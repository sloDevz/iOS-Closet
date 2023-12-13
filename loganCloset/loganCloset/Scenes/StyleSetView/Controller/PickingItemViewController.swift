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

    enum Constants {
        static let emptyViewGreetingText:String = "아이템이 없습니다. \n아이템을 등록하세요"
        static let closeButtonTitle: String = "닫기"
        static let doneButtonTitle: String = "선택"

        static let itemWidthDimensionWidth: CGFloat = 1/3
        static let itemHeightDimensionHeight: CGFloat = 1
        static let itemContentInset: CGFloat = 8

        static let groupWidthDimensionWidth: CGFloat = 1
        static let groupHeightDimensionWidth: CGFloat = 1/3

        static let SelectStateCellCornerRadius: CGFloat = 16
        static let selectedCellBorderWidth: CGFloat = 5
        static let selectionStateTransformScaleXY: CGFloat = 1.2
        static let selectionStateAnimateDuration: CGFloat = 0.1
    }

    // MARK: - Properties
    var delegate: ClothesDataProtocol?
    var category: ClothesCategory?
    var clothesManager: ClothesManager?
    private lazy var dataSource: DataSource = configureDataSource()
    var selectedItem: Clothes?
    var selectedCellIndexPath: IndexPath?

    // MARK: - UI Components
    private let emptyGuideView = EmptyViewGuide(text: Constants.emptyViewGreetingText)
    private let navigationBar = UINavigationBar()

    private lazy var closeButton: UIBarButtonItem = {
        let button  = UIBarButtonItem()
        button.title = Constants.closeButtonTitle
        button.style = .plain
        button.target = self
        button.action = #selector(closeButtonTapped)
        return button
    }()
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = Constants.doneButtonTitle
        button.style = .done
        button.target = self
        button.action = #selector(doneButtonTapped)
        return button
    }()

    private lazy var categorizedCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())

        return collectionView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
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

    // MARK: - Private
    private func setNaviBar() {
        let navigationItem = UINavigationItem()
        navigationItem.setRightBarButton(doneButton, animated: true)
        navigationItem.setLeftBarButton(closeButton, animated: true)
        navigationBar.setItems([navigationItem], animated: true)
    }

    private func setupUILayout() {
        view.addSubview(navigationBar)
        view.addSubview(categorizedCollectionView)
        view.addSubview(emptyGuideView)


        navigationBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.leading.top.trailing.equalToSuperview()
        }
        categorizedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        emptyGuideView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
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
                widthDimension: .fractionalWidth(Constants.itemWidthDimensionWidth),
                heightDimension: .fractionalHeight(Constants.itemHeightDimensionHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let inset = CGFloat(Constants.itemContentInset)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Constants.groupWidthDimensionWidth),
                heightDimension: .fractionalWidth(Constants.groupHeightDimensionWidth)
            )
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
              let selectedCategoryItems = clothesManager?.fetchCloset(of: category)
        else {
                  emptyGuideView.isHidden = false
                  return
              }
        emptyGuideView.isHidden = true

        var snapShot = SnapShot()
        snapShot.appendSections([Section.main])
        snapShot.appendItems(selectedCategoryItems)

        dataSource.apply(snapShot, animatingDifferences: animation)
    }

    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }

    @objc
    private func doneButtonTapped() {
        guard let selectedItem else { return }
        delegate?.updateClothesData(data: selectedItem, flag: false)
        dismiss(animated: true)
    }


}

extension PickingItemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

        if let selectedCellIndexPath,
           let preSelectedCell = collectionView.cellForItem(at: selectedCellIndexPath) as? StyleItemCell {
            preSelectedCell.toggleSelectiedSign()
            preSelectedCell.layer.cornerRadius = Constants.SelectStateCellCornerRadius
            preSelectedCell.layer.borderWidth = .zero
            preSelectedCell.layer.borderColor = UIColor.clear.cgColor
            UIView.animate(withDuration: Constants.selectionStateAnimateDuration) {
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
            selectedCell.layer.cornerRadius = Constants.SelectStateCellCornerRadius
            selectedCell.layer.borderWidth = Constants.selectedCellBorderWidth
            selectedCell.layer.borderColor = UIColor.separator.cgColor
            UIView.animate(withDuration: Constants.selectionStateAnimateDuration) {
                let scaleXY = Constants.selectionStateTransformScaleXY
                selectedCell.transform = CGAffineTransform(scaleX: scaleXY, y: scaleXY)
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
