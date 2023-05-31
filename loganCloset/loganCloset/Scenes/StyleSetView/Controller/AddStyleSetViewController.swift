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
    }
    // MARK: - Properties
    var delegate: StyleSetDataProtocol?
    var clotehsManager: ClothesManager?
    var currentSelectedItemButton: ItemImageButton?
    var generatedStyleSet: [Clothes]?
    var selectedBackground: UIImage?
    private lazy var photoPicker: PHPickerViewController = {
        let picker = PHPickerViewController(configuration: createPHPickerConfiguration())
        picker.delegate = self
        return picker
    }()

    // MARK: - UI Components
    private let selectBackgroundbutton = UIButton()

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
    lazy var clothesitemButtons: [ItemImageButton] = [
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))

        clothesitemButtons.forEach { button in
            button.addTarget(self, action: #selector(itemAddButtonTapped), for: .touchUpInside)
        }
        accessoryAddButtons.forEach { button in
            button.addTarget(self, action: #selector(itemAddButtonTapped), for: .touchUpInside)
        }

        selectBackgroundbutton.setImage(UIImage(named: "backgroundIcon") ?? UIImage(systemName: "person.and.background.dotted"), for: .normal)
        selectBackgroundbutton.addTarget(self, action: #selector(selectBackgroundbuttonTapped), for: .touchUpInside)
    }

    private func presentMessageAlert(title: String?, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "확인", style: .default,handler: handler)

        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
    }

    private func configureHierarchy() {
        topItemAddButtonHStackView.addArrangedSubview(topAddButton)
        topItemAddButtonHStackView.addArrangedSubview(outerAddButton)

        accessoryAddButtons.forEach { button in
            accessoryAddButtonHStackView.addArrangedSubview(button)
        }

        view.addSubview(selectBackgroundbutton)
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

        selectBackgroundbutton.snp.makeConstraints { make in
            make.bottom.equalTo(footwearAddButton.snp.bottom)
            make.leading.equalTo(footwearAddButton.snp.trailing).offset(20)
            make.width.height.equalTo(50)
        }

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

    private func createPHPickerConfiguration() -> PHPickerConfiguration {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        return configuration
    }

    @objc
    private func selectBackgroundbuttonTapped() {
        self.present(photoPicker, animated: true)
    }

    @objc
    private func doneButtonTapped() {

        let selectedClothesItems = clothesitemButtons.compactMap { button in
            button.clothes
        }
        let selectedAccessoies = accessoryAddButtons.compactMap { button in
            button.clothes
        }
        let allSelectedItems = selectedClothesItems + selectedAccessoies

        if allSelectedItems.isEmpty {
            presentMessageAlert(title: "아이템이 없어요", message: "StyleSet을 구성할 아이템들을 등록해주세요")
            return
        }

        let alertController = UIAlertController(
            title: "Style Set 이름",
            message: "Style Set에 어울리는 이름을 정해주세요",
            preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Style set 이름을 입력하세요"
        }

        let doneAction = UIAlertAction(title: "등록", style: .default) { _ in
            let inputedSetTitle = alertController.textFields?.first?.text

            if let styleSetTitle = inputedSetTitle?.trimmingCharacters(in: .whitespacesAndNewlines), !styleSetTitle.isEmpty {
                var newStyleSet = StyleSet(name: styleSetTitle, items: allSelectedItems, genDate: Date())
                newStyleSet.backgroundImage = self.selectedBackground
                self.delegate?.updateStyleSetData(data: newStyleSet)
                self.presentMessageAlert(title: "Style set 등록", message: "새로운 Style set이 등록되었습니다.") { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            }

            self.presentMessageAlert(title: "입력오류", message: "잘못된 입력입니다. 올바른 이름을 입력하세요") { _ in
                self.present(alertController, animated: true)
            }

        }

        let cancelAntion = UIAlertAction(title: "취소", style: .cancel) { _ in
            return
        }

        alertController.addAction(doneAction)
        alertController.addAction(cancelAntion)


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
              let clotehsManager else { return }
        currentSelectedItemButton = sender
        let ItemPickingVC = PickingItemViewController(category: category,
                                                      clothesManager: clotehsManager)
        ItemPickingVC.delegate = self
        self.present(ItemPickingVC, animated: true)
    }

}

extension AddStyleSetViewController: ClothesDataProtocol {

    func updateClothesData(data: Clothes?) {
        guard let data else { return }
        currentSelectedItemButton?.updateItemData(with: data)
        currentSelectedItemButton = nil
    }

}

extension AddStyleSetViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        photoPicker.dismiss(animated: true)

        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.selectedBackground = image as? UIImage
                }
            }
        }
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
