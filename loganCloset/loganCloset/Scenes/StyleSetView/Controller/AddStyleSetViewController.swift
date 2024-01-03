//
//  AddStyleSetViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/28.
//

import UIKit
import SnapKit
import PhotosUI

final class AddStyleSetViewController: UIViewController {

    // MARK: - Constants
    private enum Constant {
        static let clothesAddButtonContainerInset: CGFloat = 120
        static let accessoryAddButtonSquareSize: CGFloat = 70
        static let addHeadButtonTopInset: CGFloat = 100
        static let clothesItemsOffset: CGFloat = 10
        static let accessoryHStackBottomInset: CGFloat = 50
        static let topItemAddButtonHStackViewSpacing: CGFloat = 15
        static let accessoryAddButtonHStackViewSpacing: CGFloat = 10

        static let navigationBarbuttonItemDoneTitle: String = "완료"
        static let alertActionTitle:String = "확인"

        static let buttonWidthHeightMulitiplyForClothes: CGFloat = 0.2
        static let buttonWidthHeightMulitiplyForAccessory: CGFloat = 0.1
        static let accessoryAddButtonHStackViewBottomInset: CGFloat = 25.0

        static let alertTitleForSelectedItemsIsEmpty: String = "아이템이 없어요"
        static let alertMessageForSelectedItemsIsEmpty: String = "StyleSet을 구성할 아이템들을 등록해주세요"
        static let alertTitleForSettingStyleSetName: String = "Style Set 이름"
        static let alertMessageForSettingStyleSetName: String = "Style Set에 어울리는 이름을 정해주세요"

        static let placeholderForSetStyleName: String = "Style set 이름을 입력하세요"
        static let alertConfirmButtonText: String = "등록"

        static let completedRegestedStyleSetAlertTitle: String = "Style set 등록"
        static let completedRegestedStyleSetAlertMessage: String = "새로운 Style set이 등록되었습니다."

        static let inputErrorAlertTitle: String = "입력오류"
        static let inputErrorAlertMessage: String = "잘못된 입력입니다. 올바른 이름을 입력하세요"

        static let cancelActionAlertButtonTitle: String = "취소"
    }

    // MARK: - Properties
    var selectedStyleSet: StyleSet?
    var delegate: StyleSetDataProtocol?
    var clothesManager: ClothesManager?
    var currentSelectedItemButton: ItemImageButton?

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
    lazy var clothesItemButtons: [ItemImageButton] = [
        headAddButton,
        outerAddButton,
        topAddButton,
        bottomAddButton,
        footwearAddButton,
    ]
    private let topItemAddButtonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constant.topItemAddButtonHStackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let accessoryAddButtonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constant.accessoryAddButtonHStackViewSpacing
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

    init(clotheManager: ClothesManager) {
        super.init(nibName: nil, bundle: nil)
        clothesManager = clotheManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constant.navigationBarbuttonItemDoneTitle,
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        clothesItemButtons.forEach { button in
            button.addTarget(self, action: #selector(itemAddButtonTapped), for: .touchUpInside)
        }
        accessoryAddButtons.forEach { button in
            button.addTarget(self, action: #selector(itemAddButtonTapped), for: .touchUpInside)
        }
    }

    private func presentMessageAlert(title: String?, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: Constant.alertActionTitle, style: .default,handler: handler)

        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
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
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(Constant.buttonWidthHeightMulitiplyForClothes)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        topAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(Constant.buttonWidthHeightMulitiplyForClothes)
        }
        topItemAddButtonHStackView.snp.makeConstraints { make in
            make.top.equalTo(headAddButton.snp.bottom).offset(Constant.clothesItemsOffset)
            make.centerX.equalToSuperview()
        }
        bottomAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(Constant.buttonWidthHeightMulitiplyForClothes)
            make.top.equalTo(topItemAddButtonHStackView.snp.bottom).offset(Constant.clothesItemsOffset)
            make.centerX.equalToSuperview()
        }
        footwearAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(Constant.buttonWidthHeightMulitiplyForClothes)
            make.top.equalTo(bottomAddButton.snp.bottom).offset(Constant.clothesItemsOffset)
            make.centerX.equalToSuperview()
        }

        accessoryAddButtons.first?.snp.makeConstraints({ make in
            make.width.height.equalTo(clothesButtonContainer.snp.height).multipliedBy(Constant.buttonWidthHeightMulitiplyForAccessory)
        })
        accessoryAddButtonHStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(tabbarHeight + Constant.accessoryAddButtonHStackViewBottomInset)
            make.centerX.equalToSuperview()
        }
    }

    private func createPHPickerConfiguration() -> PHPickerConfiguration {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        return configuration
    }

    @objc
    private func doneButtonTapped() {

        let selectedClothesItems = clothesItemButtons.compactMap { button in
            button.clothes
        }
        let selectedAccessoies = accessoryAddButtons.compactMap { button in
            button.clothes
        }
        let allSelectedItems = selectedClothesItems + selectedAccessoies

        if allSelectedItems.isEmpty {
            presentMessageAlert(
                title: Constant.alertTitleForSelectedItemsIsEmpty,
                message: Constant.alertMessageForSelectedItemsIsEmpty
            )
            return
        }

        let alertController = UIAlertController(
            title: Constant.alertTitleForSettingStyleSetName,
            message: Constant.alertMessageForSettingStyleSetName,
            preferredStyle: .alert
        )

        alertController.addTextField { textField in
            textField.placeholder = Constant.placeholderForSetStyleName
        }

        let doneAction = UIAlertAction(
            title: Constant.alertConfirmButtonText,
            style: .default) { _ in
            let inputedSetTitle = alertController.textFields?.first?.text

            if let styleSetTitle = inputedSetTitle?.trimmingCharacters(in: .whitespacesAndNewlines), !styleSetTitle.isEmpty {
                let newStyleSet = StyleSet(
                    name: styleSetTitle,
                    items: allSelectedItems
                )
                self.delegate?.updateStyleSetData(data: newStyleSet)
                self.presentMessageAlert(
                    title: Constant.completedRegestedStyleSetAlertTitle,
                    message: Constant.completedRegestedStyleSetAlertMessage) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            }

                self.presentMessageAlert(
                    title: Constant.inputErrorAlertTitle,
                    message: Constant.inputErrorAlertMessage ) { _ in
                self.present(alertController, animated: true)
            }

        }

        let cancelAction = UIAlertAction(
            title: Constant.cancelActionAlertButtonTitle,
            style: .cancel) { _ in
            return
        }

        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)

    }

    private func popAlertViewWithTextField(title: String, message: String, placeholder: String,doneTitle: String, canelTitle: String, complition: @escaping (UIAlertAction) -> ()) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alertController.addTextField { texField in
            texField.placeholder = placeholder
        }

        let doneAction = UIAlertAction(title: doneTitle, style: .default,handler: complition)
        let cancelAction = UIAlertAction(title: canelTitle, style: .cancel)

        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    @objc
    private func itemAddButtonTapped(sender: ItemImageButton) {
        guard let category = sender.category,
              let clothesManager else { return }
        currentSelectedItemButton = sender
        let items = clothesManager.fetchCloset(of: category)
        let ItemPickingVC = PickingItemViewController(items: items)
        ItemPickingVC.delegate = self
        self.present(ItemPickingVC, animated: true)
    }

}

extension AddStyleSetViewController: ClothesDataProtocol {

    func updateClothesData(data: Clothes?, flag: Bool) {
        guard let data else { return }
        currentSelectedItemButton?.updateItemData(with: data)
        currentSelectedItemButton = nil
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
