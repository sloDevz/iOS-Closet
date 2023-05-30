//
//  AddClothesViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/30.
//

import UIKit

final class AddClothesViewController: UIViewController {

    // MARK: - Constants
    enum Constants {
        static let offsetOfEachUIComponents: CGFloat = 15
        static let offsetPhotoAndOthers: CGFloat = 30
    }

    // MARK: - Properties
    var delegate: ClothesDataProtocol?
    private var addClothesScrollView: UIScrollView =  UIScrollView()
    var contentView = UIView()

    var clothesImage: UIImage?
    var category: ClothesCategory?
    var season: Season?
    var itemTags: String?
    var brandName: String?
    var meterial: String?

    private let colors = MainColor.allCases
    private let materials = Material.allCases

    // MARK: - UI Components
    private let cancelButton: UIButton = {
        let button = UIButton()
        let titlefont = UIFont.importedUIFont(name: .pretendardBold, fontSize: 18)
        button.setTitle("취소", for: .normal)
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
        
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    private let seasonSelectSegment: UISegmentedControl = {
        let seasons = Season.allCases.map { season in
            season.rawValue
        }
        let segmentControl = UISegmentedControl(items: seasons)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    private let tagInputTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "원하는 #Tag를 입력해주세요"
        textfield.textAlignment = .center
        textfield.returnKeyType = .done
        textfield.backgroundColor = .systemGray5
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    private let brandNameInputTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "브랜드 이름을 입력해주세요"
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
        textfield.placeholder = "주색상을 선택해주세요"
        textfield.textAlignment = .center
        textfield.backgroundColor = .systemGray5
        textfield.tintColor = textfield.backgroundColor
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    private let materialPickerTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "소재를 선택해주세요"
        textfield.textAlignment = .center
        textfield.backgroundColor = .systemGray5
        textfield.tintColor = textfield.backgroundColor
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    private let confirmButton: UIButton = {
        let button = UIButton()
        let titlefont = UIFont.importedUIFont(name: .pretendardBold, fontSize: 20)
        button.backgroundColor = .black
        button.setTitle("등록하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = titlefont
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIComponents()
        setupAppearance()
        configureHierarchy()
        configureLayoutConstraint()
        setKeyboardNotification()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    // MARK: - Private
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
        categorySelectSegment.addTarget(self, action: #selector(categorySegmentValueChanged), for: .valueChanged)
        seasonSelectSegment.addTarget(self, action: #selector(seasonSegmentValueChanged), for: .valueChanged)

        tagInputTextField.delegate = self
        brandNameInputTextField.delegate = self

        setupMainColorAndMaterialPickerView()

        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        confirmButton.setTitleColor(.cyan, for: .highlighted)
    }

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

    @objc
    private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    @objc
    private func confirmButtonTapped() {
        print(#function)
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let mainWindow = UIApplication.shared.windows.first else { return }
        view.frame.origin.y = mainWindow.frame.origin.y

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
           let keybaordRectangle = keyboardFrame.cgRectValue
           let keyboardHeight = keybaordRectangle.height
           view.frame.origin.y -= keyboardHeight
         }
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
          let keybaordRectangle = keyboardFrame.cgRectValue
          let keyboardHeight = keybaordRectangle.height
          view.frame.origin.y += keyboardHeight
        }
    }

    @objc
    private func photoButtonTapped() {
        print(#function)
    }

    @objc
    private func categorySegmentValueChanged(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }

    @objc
    private func seasonSegmentValueChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex

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
        view.backgroundColor = .white
    }

    private func configureHierarchy() {
        view.addSubview(addClothesScrollView)
        addClothesScrollView.addSubview(contentView)
        contentView.addSubview(cancelButton)
        contentView.addSubview(seperatorView)
        contentView.addSubview(photoButton)
        contentView.addSubview(categorySelectSegment)
        contentView.addSubview(seasonSelectSegment)
        contentView.addSubview(tagInputTextField)
        contentView.addSubview(brandNameInputTextField)
        contentView.addSubview(colorPickerTextField)
        contentView.addSubview(materialPickerTextField)
        contentView.addSubview(confirmButton)
    }

    private func configureLayoutConstraint() {
        addClothesScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(confirmButton).offset(30)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        seperatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.top.equalTo(cancelButton.snp.bottom).offset(20)
        }
        photoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(seperatorView.snp.bottom).offset(10)
            make.width.height.equalTo(contentView.snp.width).inset(20)
        }
        categorySelectSegment.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.top.equalTo(photoButton.snp.bottom).offset(Constants.offsetPhotoAndOthers)
            make.centerX.equalToSuperview()
        }
        seasonSelectSegment.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.top.equalTo(categorySelectSegment.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.centerX.equalToSuperview()
        }
        tagInputTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.top.equalTo(seasonSelectSegment.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.centerX.equalToSuperview()
        }
        brandNameInputTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.top.equalTo(tagInputTextField.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.centerX.equalToSuperview()
        }
        colorPickerTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(brandNameInputTextField.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        materialPickerTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(colorPickerTextField.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(materialPickerTextField.snp.bottom).offset(Constants.offsetOfEachUIComponents)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }


}


extension AddClothesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
            colorPickerTextField.resignFirstResponder()

        } else if pickerView == materialPicker {
            let selectedMaterial = materials[row]
            materialPickerTextField.text = selectedMaterial.rawValue
            materialPickerTextField.resignFirstResponder()
        }
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
