//
//  AddClothesViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/30.
//

import UIKit
import SnapKit
import PhotosUI

final class AddClothesViewController: UIViewController {

    // MARK: - Constants
    enum Constants {
        static let offsetOfEachUIComponents: CGFloat = 15
        static let offsetPhotoAndOthers: CGFloat = 30
        static let confirmButtonRadius: CGFloat = 8
        static let confirmButtonHeight: CGFloat = 60

        static let closetButtonTitle: String = "닫기"
        static let tagTextFieldPlaceholder: String = "원하는 #Tag를 입력해주세요"
        static let brandTextFieldPlaceholder: String = "브랜드 이름을 입력해주세요"
        static let mainColorTextFieldPlaceholder: String = "주색상을 선택해주세요"
        static let materialTextFieldPlaceholder: String = "소재를 선택해주세요"

        static let confirmButtonTitle: String = "등록하기"
        static let confirmMessageTitle: String = "아이템 등록"
        static let confirmMessageText: String = "새로운 아이템을 등록했습니다."
        static let confirmButtonFontSize: CGFloat = 20

        static let closeButtonHeight: CGFloat = 20
        static let closeButtonFontSize: CGFloat = 18
        static let seperatorHeight: CGFloat = 1
        static let seperatorViewOffset:CGFloat = 10
        static let seperatorAndPhotoButtonInset: CGFloat = 20
        static let widthHeightInset: CGFloat = 40
        static let viewSideInset: CGFloat = 20
        static let contentTextFieldHeight: CGFloat = 40
    }

    // MARK: - Properties
    var delegate: ClothesDataProtocol?
    var firstSelectedindex: Int?
    private var clothesImage: UIImage? {
        willSet {
            photoButton.setImage(newValue, for: .normal)
        }
    }
    private var category: ClothesCategory? = nil
    private var season: Season = .all
    private var itemTags: [String]? = nil
    private var brandName: String? = nil
    private var material: Material? = nil
    private var mainColor: MainColor? = nil

    private let colors = MainColor.allCases
    private let materials = Material.allCases

    // MARK: - UI Components
    private var addClothesScrollView =  UIScrollView()
    private var contentView = UIView()
    private var keyboardSapceView = UIView()
    private let closeButton: UIButton = {
        let button = UIButton()
        let titlefont = UIFont.importedUIFont(name: .pretendardBold, fontSize: Constants.closeButtonFontSize)
        button.setTitle(Constants.closetButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = titlefont
        return button
    }()
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    private let photoButton = PhotoButton()
    private let categorySelectSegment: UISegmentedControl = {
        let categories = ClothesCategory.allCases.dropFirst().map { category in
            category.rawValue
        }
        let segmentControl = UISegmentedControl(items: categories)

        segmentControl.selectedSegmentIndex = .zero
        return segmentControl
    }()
    private let seasonSelectSegment: UISegmentedControl = {
        let seasons = Season.allCases.map { season in
            season.rawValue
        }
        let segmentControl = UISegmentedControl(items: seasons)
        segmentControl.selectedSegmentIndex = .zero
        return segmentControl
    }()
    private let tagInputTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Constants.tagTextFieldPlaceholder
        textfield.textAlignment = .center
        textfield.returnKeyType = .done
        textfield.backgroundColor = .systemGray5
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    private let brandNameInputTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Constants.brandTextFieldPlaceholder
        textfield.textAlignment = .center
        textfield.returnKeyType = .done
        textfield.backgroundColor = .systemGray5
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    private let colorPicker = UIPickerView()
    private let materialPicker = UIPickerView()
    private let colorPickerTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Constants.mainColorTextFieldPlaceholder
        textfield.textAlignment = .center
        textfield.backgroundColor = .systemGray5
        textfield.tintColor = textfield.backgroundColor
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    private let materialPickerTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Constants.materialTextFieldPlaceholder
        textfield.textAlignment = .center
        textfield.backgroundColor = .systemGray5
        textfield.tintColor = textfield.backgroundColor
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    private let confirmButton: UIButton = {
        let button = UIButton()
        let titlefont = UIFont.importedUIFont(name: .pretendardBold, fontSize: Constants.confirmButtonFontSize)
        button.backgroundColor = .black
        button.setTitle(Constants.confirmButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.cyan, for: .selected)
        button.setTitleColor(.cyan, for: .highlighted)
        button.titleLabel?.font = titlefont
        button.layer.cornerRadius = Constants.confirmButtonRadius
        return button
    }()
    private lazy var photoPicker: PHPickerViewController = {
        let picker = PHPickerViewController(configuration: createPHPickerConfiguration())
        picker.delegate = self
        return picker
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIComponents()
        setupAppearance()
        configureHierarchy()
        configureLayoutConstraint()
        setKeyboardNotification()
        hideKeyboardWhenTappedAround()

    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeKeyboardNotification()
    }

    // MARK: - Public

    // MARK: - Private
    private func createPHPickerConfiguration() -> PHPickerConfiguration {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        return configuration
    }
    private func setupMainColorAndMaterialPickerView() {
        colorPicker.delegate = self
        colorPicker.dataSource = self

        materialPicker.delegate = self
        materialPicker.dataSource = self

        colorPickerTextField.borderStyle = .roundedRect
        colorPickerTextField.inputView = colorPicker
        materialPickerTextField.borderStyle = .roundedRect
        materialPickerTextField.inputView = materialPicker
    }

    private func configureUIComponents() {
        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)

        tagInputTextField.delegate = self
        brandNameInputTextField.delegate = self

        setupMainColorAndMaterialPickerView()

        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        categorySelectSegment.selectedSegmentIndex = firstSelectedindex ?? .zero
    }

    @objc
    private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    @objc
    private func confirmButtonTapped() {
        setSeasonBySegment()
        setCategoryBySegment()

        guard let clothesImage,
              let category else { return }

        let newItem = Clothes(itemImage: clothesImage, clothesCategory: category, season: season, mainColor: mainColor, tags: itemTags, brandName: brandName, meterial: material)
        delegate?.updateClothesData(data: newItem)
        AlertManager.presentMessageAlert(
            viewController: self,
            title: Constants.confirmButtonTitle,
            message: Constants.confirmMessageText
        ) { _ in
            self.dismiss(animated: true)
        }
    }

    @objc
    private func photoButtonTapped() {
        self.present(photoPicker, animated: true)
    }

    @objc
    private func setCategoryBySegment() {
        let selectedIndex = categorySelectSegment.selectedSegmentIndex

        switch selectedIndex {
        case 0:
            self.category = .hat
        case 1:
            self.category = .outer
        case 2:
            self.category = .top
        case 3:
            self.category = .bottom
        case 4:
            self.category = .footWaer
        case 5:
            self.category = .accessory
        default:
            self.category = ClothesCategory.none
        }
    }

    @objc
    private func setSeasonBySegment() {
        let selectedIndex = seasonSelectSegment.selectedSegmentIndex

        switch selectedIndex {
        case 0:
            self.season = .all
        case 1:
            self.season = .spring
        case 2:
            self.season = .summer
        case 3:
            self.season = .fall
        case 4:
            self.season = .winter
        default:
            self.season = Season.all
        }
    }

    private func setupAppearance() {
        view.backgroundColor = .systemBackground
    }

    private func configureHierarchy() {
        view.addSubview(closeButton)
        view.addSubview(seperatorView)
        view.addSubview(addClothesScrollView)
        view.addSubview(confirmButton)
        addClothesScrollView.addSubview(contentView)
        contentView.addSubview(photoButton)
        contentView.addSubview(categorySelectSegment)
        contentView.addSubview(seasonSelectSegment)
        contentView.addSubview(tagInputTextField)
        contentView.addSubview(brandNameInputTextField)
        contentView.addSubview(colorPickerTextField)
        contentView.addSubview(materialPickerTextField)
        contentView.addSubview(keyboardSapceView)
    }

    private func configureLayoutConstraint() {
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.closeButtonHeight)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(Constants.viewSideInset)
        }
        seperatorView.snp.makeConstraints { make in
            make.height.equalTo(Constants.seperatorHeight)
            make.width.equalToSuperview()
            make.top.equalTo(closeButton.snp.bottom).offset(Constants.seperatorViewOffset)
            make.centerX.equalToSuperview()
        }
        addClothesScrollView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom )
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(confirmButton.snp.top)
        }
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.confirmButtonHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.offsetOfEachUIComponents)
            make.leading.trailing.equalToSuperview().inset(Constants.viewSideInset)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(keyboardSapceView)
        }
        photoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.seperatorAndPhotoButtonInset)
            make.width.height.equalTo(contentView.snp.width).inset(Constants.widthHeightInset)
        }
        categorySelectSegment.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(Constants.viewSideInset)
            make.height.equalTo(Constants.contentTextFieldHeight)
            make.top.equalTo(photoButton.snp.bottom).offset(Constants.offsetPhotoAndOthers)
            make.centerX.equalToSuperview()
        }
        seasonSelectSegment.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(Constants.viewSideInset)
            make.height.equalTo(Constants.contentTextFieldHeight)
            make.top.equalTo(categorySelectSegment.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.centerX.equalToSuperview()
        }
        tagInputTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(Constants.viewSideInset)
            make.height.equalTo(Constants.contentTextFieldHeight)
            make.top.equalTo(seasonSelectSegment.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.centerX.equalToSuperview()
        }
        brandNameInputTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(Constants.viewSideInset)
            make.height.equalTo(Constants.contentTextFieldHeight)
            make.top.equalTo(tagInputTextField.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.centerX.equalToSuperview()
        }
        colorPickerTextField.snp.makeConstraints { make in
            make.height.equalTo(Constants.contentTextFieldHeight)
            make.top.equalTo(brandNameInputTextField.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.leading.trailing.equalToSuperview().inset(Constants.viewSideInset)
        }
        materialPickerTextField.snp.makeConstraints { make in
            make.height.equalTo(Constants.contentTextFieldHeight)
            make.top.equalTo(colorPickerTextField.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.leading.trailing.equalToSuperview().inset(Constants.viewSideInset)
        }
        keyboardSapceView.snp.makeConstraints { make in
            make.height.equalTo(Constants.offsetOfEachUIComponents)
            make.top.equalTo(materialPickerTextField.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()

        }
    }


}

extension AddClothesViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        photoPicker.dismiss(animated: true)

        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.clothesImage = image as? UIImage
                }
            }
        }
    }
}

extension AddClothesViewController {

    private func setKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height - Constants.confirmButtonHeight

            keyboardSapceView.snp.updateConstraints { make in
                make.height.equalTo(keyboardHeight)
            }
            addClothesScrollView.setContentOffset(CGPoint(x: .zero, y: keyboardHeight), animated: true)
        }
    }

    @objc
    private func keyboardWillHide() {
        keyboardSapceView.snp.updateConstraints { make in
            make.height.equalTo(Constants.offsetOfEachUIComponents)
        }
        addClothesScrollView.setContentOffset(CGPoint(x: .zero, y: 0), animated: true)
    }

}

extension AddClothesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let typedText = text.trimmingCharacters(in: .whitespacesAndNewlines)

        switch textField {
        case tagInputTextField:
            if !typedText.isEmpty {
                itemTags = typedText.transformIntoTag()
            } else {
                itemTags = nil
            }
        case brandNameInputTextField:
            if !typedText.isEmpty {
                brandName = typedText
            } else {
                brandName = nil
            }
        default:
            return
        }
    }

}

extension AddClothesViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == colorPicker {
            return colors.count
        } else if pickerView == materialPicker {
            return materials.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == colorPicker {
            return colors[row].rawValue
        } else if pickerView == materialPicker {
            return materials[row].rawValue
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == colorPicker {
            let selectedColor = colors[row]
            colorPickerTextField.text = selectedColor.rawValue
            mainColor = selectedColor
            colorPickerTextField.resignFirstResponder()

        } else if pickerView == materialPicker {
            let selectedMaterial = materials[row]
            materialPickerTextField.text = selectedMaterial.rawValue
            material = selectedMaterial
            materialPickerTextField.resignFirstResponder()
        }
    }

}

extension AddClothesViewController {

    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}


#if DEBUG
import SwiftUI
struct ViewControllerName_Previews: PreviewProvider {
    static var previews: some View { Container().edgesIgnoringSafeArea(.all) }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController { return AddClothesViewController() }
        func updateUIViewController(_ uiViewController: UIViewController,context: Context) { }
    }
}
#endif
