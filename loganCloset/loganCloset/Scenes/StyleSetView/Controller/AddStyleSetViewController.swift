//
//  AddStyleSetViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/28.
//

import UIKit
import SnapKit

final class AddStyleSetViewController: UIViewController {

    // MARK: - Constants
    private enum Constant {
        static let clothesAddButtonContainerInset: CGFloat = 120
        static let accessoryAddButtonSquareSize: CGFloat = 70
        static let addHeadButtonTopInset: CGFloat = 100
        static let clothesItemsOffset: CGFloat = 10
        static let accessoryHStackBottomInset: CGFloat = 50
    }
    // MARK: - Properties
    var clotehsManager: ClothesManager?
    var generatedStyleSet: [ClothesCategory:Clothes?] = [
        .hat : nil,
        .outer : nil,
        .top : nil,
        .bottom : nil,
        .footWaer : nil
    ]

    // MARK: - UI Components
    lazy var clothesButtonContainer: UIView = {
        let view = UIView()
        return view
    }()

    lazy var headAddButton: ItemImageButton = {
        var button = ItemImageButton(buttonFor: .hat)
        return button
    }()
    lazy var topAddButton: ItemImageButton = {
        var button = ItemImageButton(buttonFor: .top)

        return button
    }()
    lazy var outerAddButton: ItemImageButton = {
        var button = ItemImageButton(buttonFor: .outer)

        return button
    }()
    lazy var bottomAddButton: ItemImageButton = {
        var button = ItemImageButton(buttonFor: .bottom)

        return button
    }()
    lazy var footwearAddButton: ItemImageButton = {
        var button = ItemImageButton(buttonFor: .footWaer)

        return button
    }()
    lazy var accessoryAddButtons: [ItemImageButton] = {
        var buttons = [ItemImageButton]()
        for _ in 0...3 {
            buttons.append(ItemImageButton(buttonFor: .accessory))
        }

        return buttons
    }()
    lazy var ClothesitemButtons: [UIButton] = [
        headAddButton,
        outerAddButton,
        topAddButton,
        bottomAddButton,
        footwearAddButton,
    ]
    private let topItemAddButtonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let accessoryAddButtonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureHierarchy()
        configureLayoutConstraint()
    }

    init(clotheManager: ClothesManager){
        super.init(nibName: nil, bundle: nil)
        clotehsManager = clotheManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public

    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(addButtonTapped))

        ClothesitemButtons.forEach { button in
            button.addTarget(self, action: #selector(itemAddButtonTapped), for: .touchUpInside)
        }
        accessoryAddButtons.forEach { button in
            button.addTarget(self, action: #selector(itemAddButtonTapped), for: .touchUpInside)
        }
    }

    private func configureHierarchy() {
        topItemAddButtonHStackView.addArrangedSubview(topAddButton)
        topItemAddButtonHStackView.addArrangedSubview(outerAddButton)

        accessoryAddButtons.forEach { button in
            accessoryAddButtonHStackView.addArrangedSubview(button)
        }

        view.addSubview(clothesButtonContainer)
        clothesButtonContainer.addSubview(headAddButton)
        clothesButtonContainer.addSubview(topItemAddButtonHStackView)
        clothesButtonContainer.addSubview(bottomAddButton)
        clothesButtonContainer.addSubview(footwearAddButton)
        view.addSubview(accessoryAddButtonHStackView)
    }

    private func configureLayoutConstraint() {
        let tabbarHeight = tabBarController?.tabBar.frame.height ?? 50
        let containerInset = view.frame.height/8

        clothesButtonContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(containerInset)
        }

        headAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(0.2)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        topAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(0.2)
        }
        topItemAddButtonHStackView.snp.makeConstraints { make in
            make.top.equalTo(headAddButton.snp.bottom).offset(Constant.clothesItemsOffset)
            make.centerX.equalToSuperview()
        }
        bottomAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(0.2)
            make.top.equalTo(topItemAddButtonHStackView.snp.bottom).offset(Constant.clothesItemsOffset)
            make.centerX.equalToSuperview()
        }
        footwearAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(0.2)
            make.top.equalTo(bottomAddButton.snp.bottom).offset(Constant.clothesItemsOffset)
            make.centerX.equalToSuperview()
        }

        accessoryAddButtons.first?.snp.makeConstraints({ make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(0.1)
        })
        accessoryAddButtonHStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(tabbarHeight + 25.0)
            make.centerX.equalToSuperview()
        }
    }

    @objc
    private func addButtonTapped() {
        print(#function)
    }

    @objc
    private func itemAddButtonTapped(sender: ItemImageButton) {
        guard let category = sender.category,
              let clotehsManager else { return }

        let ItempickingVC = PickingItemViewController(category: category,
                                                      clothesManager: clotehsManager)
        self.present(ItempickingVC, animated: true)
    }

}

#if DEBUG
import SwiftUI
struct AddStyleSetViewController_Previews: PreviewProvider {
    static var previews: some View { Container().edgesIgnoringSafeArea(.all) }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return AddStyleSetViewController(clotheManager: ClothesManager())
        }
        func updateUIViewController(_ uiViewController: UIViewController,context: Context) { }
    }
}
#endif
