//
//  ClothesDetailViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 11/23/23.
//

import UIKit
import SnapKit

final class ClothesDetailViewController: UIViewController {
    // MARK: - Constants

    // MARK: - Properties
    private var selectedItem: Clothes?
    private var clothesManager: ClothesManager?
    // MARK: - UI Components
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var itemImage = UIImageView()
    private var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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
        super.init(nibName: nil, bundle: nil)
        self.selectedItem = selectedItem
        self.clothesManager = clothesManager
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
        contentView.addSubview(itemImage)
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
            make.bottom.equalTo(infoStackView).offset(50)
            make.width.equalTo(view.snp.width)
        }
        itemImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(view.snp.width).inset(24)
        }
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(itemImage.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    private func setUIComponents() {
        guard let selectedItem else { return }
        let tags = selectedItem.tags?.map{"#\($0)"}.joined(separator: " ")
        
        itemImage.image = selectedItem.itemImage
        categoryInfoLabelView.changeText(to: selectedItem.clothesCategory.rawValue)
        seasonInfoLabelView.changeText(to: selectedItem.season.rawValue)
        tagInfoLabelView.changeText(to: tags ?? "-")
        brandInfoLabelView.changeText(to: selectedItem.brandName ?? "-")
        colorInfoLabelView.changeText(to: selectedItem.mainColor?.rawValue ?? "-")
        materialInfoLabelView.changeText(to: selectedItem.meterial?.rawValue ?? "-")
    }

}
