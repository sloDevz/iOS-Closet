//
//  ClothesDetailViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 11/23/23.
//

import UIKit
import SnapKit

final class ClothesDetailViewController: UIViewController, ClothesDataProtocol {
    // MARK: - Constants

    // MARK: - Properties
    private var selectedItem: Clothes
    private var clothesManager: ClothesManager?
    // MARK: - UI Components
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        let offset = 1
        view.layer.shadowOffset = CGSize(width: offset, height: offset)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 40
        return view
    }()
    private var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    private var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    private var categoryInfoLabelView = TitleAndTextLabelView(title: "Category")
    private var seasonInfoLabelView = TitleAndTextLabelView(title: "Season")
    private var tagInfoLabelView = TitleAndTextLabelView(title: "Tag")
    private var brandInfoLabelView = TitleAndTextLabelView(title: "Brand")
    private var colorInfoLabelView = TitleAndTextLabelView(title: "Color")
    private var materialInfoLabelView = TitleAndTextLabelView(title: "Material")

    // MARK: - LifeCycle
    init(selectedItem: Clothes, clothesManager: ClothesManager) {
        self.selectedItem = selectedItem
        self.clothesManager = clothesManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUIComponents()
        configureHierarchy()
        configureLayoutConstraint()
    }


    // MARK: - Public

    // MARK: - Private
    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentContainer.addSubview(itemImage)
        contentView.addSubview(contentContainer)
        contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(categoryInfoLabelView)
        infoStackView.addArrangedSubview(seasonInfoLabelView)
        infoStackView.addArrangedSubview(tagInfoLabelView)
        infoStackView.addArrangedSubview(brandInfoLabelView)
        infoStackView.addArrangedSubview(colorInfoLabelView)
        infoStackView.addArrangedSubview(materialInfoLabelView)
    }
    private func configureLayoutConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.bottom.equalTo(infoStackView).offset(30)
            make.width.equalTo(view.snp.width)
        }
        contentContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(view.snp.width).inset(48)
        }
        itemImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(contentContainer.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(48)
        }
    }
    private func setUIComponents() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonTapped))
        setItemInfoUIComponents()
    }

    private func setItemInfoUIComponents() {
        let tags = selectedItem.tags?.joined(separator: " ")
        itemImage.image = selectedItem.itemImage
        categoryInfoLabelView.changeText(to: selectedItem.clothesCategory.rawValue)
        seasonInfoLabelView.changeText(to: selectedItem.season.rawValue)
        tagInfoLabelView.changeText(to: tags ?? "-")
        brandInfoLabelView.changeText(to: selectedItem.brandName ?? "-")
        colorInfoLabelView.changeText(to: selectedItem.mainColor?.rawValue ?? "-")
        materialInfoLabelView.changeText(to: selectedItem.material?.rawValue ?? "-")
    }

    @objc
    private func editButtonTapped() {
        let addClothesVC = EditClothesViewController(eiditFrom: selectedItem)
        addClothesVC.delegate = self
        addClothesVC.modalPresentationStyle = .fullScreen
        present(addClothesVC, animated: true)
    }

}

extension ClothesDetailViewController {
    func updateClothesData(data: Clothes?, flag: Bool) {
        guard let data else { return }
        if flag {
            clothesManager?.delete(clothes: data)
            navigationController?.popViewController(animated: true)
        } else {
            clothesManager?.replaceClothes(selectedItem, with: data)
            selectedItem = data
            setItemInfoUIComponents()
        }
    }
}

