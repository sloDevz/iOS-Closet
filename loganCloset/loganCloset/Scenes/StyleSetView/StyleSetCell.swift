//
//  StyleSetCell.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/25.
//

import UIKit
import SnapKit

final class StyleSetCell: UICollectionViewCell {

    // MARK: - Constants
    enum Constants {
        static let containerRadius: CGFloat = 8
        static let contentContainerShadowInset: CGFloat = 1
        static let contentContainerShadowOpacity: Float = 0.1
        static let contentContainerShoadowRadius: CGFloat = 40

        static let descriptionLabelFontSize: CGFloat = 14
        static let descriptionLabelSkeletonText: String = "My StyleSet"

        static let horizontalStackSpacing: CGFloat = 6
        static let verticalStackSpacing: CGFloat = 16

        static let stackViewContainerMultipliedHeight: CGFloat = 0.78
        static let styleSetVerticalStackWidthInset: CGFloat = 16
        static let styleSetVerticalStackHeightInset: CGFloat = 24
        static let borderLineHeight: CGFloat = 1
        static let descriptionLabelMultipliedHeight: CGFloat = 0.22
    }

    // MARK: - Properties
    static let reuseidentifier = String(describing: StyleSetCell.self)
    
    // MARK: - UI Components
    private let contentContainer: UIView = {
        let view =  UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.containerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(
            width: Constants.contentContainerShadowInset,
            height: Constants.contentContainerShadowInset)
        view.layer.shadowOpacity = Constants.contentContainerShadowOpacity
        view.layer.shadowRadius = Constants.contentContainerShoadowRadius
        return view
    }()
    private let stackViewContainer: UIView = {
        let view =  UIView()
        view.layer.cornerRadius = Constants.containerRadius
        view.backgroundColor = .white
        return view
    }()
    private let itemImages: [UIImageView] = {
        var imageViews = [UIImageView]()
        for _ in 0 ... 3 {
            let itemImage: UIImageView = {
                let image = UIImageView()
                image.contentMode = .scaleAspectFit
                return image
            }()
            imageViews.append(itemImage)
        }
        return imageViews
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.descriptionLabelSkeletonText
        label.textColor = .black
        label.font = UIFont.importedUIFont(
            name: .pretendardBold,
            fontSize: Constants.descriptionLabelFontSize
        )
        label.textAlignment = .center
        return label
    }()
    private let borderLine: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return view
    }()
    private var styleSetHorizontalInnerStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.horizontalStackSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var styleSetHorizontalInnerStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.horizontalStackSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var styleSetVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.verticalStackSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func configureItemImage(with styleSet: StyleSet) {
        var styleSetImages = styleSet.items.compactMap { $0.itemImage }
        styleSetImages.reverse()

        itemImages.forEach { imageView in
            imageView.image = styleSetImages.popLast() ?? UIImage(named: ImageConstants.noneImage)
        }
        descriptionLabel.text = styleSet.name
    }

    // MARK: - Private
    private func configureHierachy() {
        var indexCount = 0
        itemImages.forEach { itemImage in
            if indexCount < 2 {
                styleSetHorizontalInnerStackView1.addArrangedSubview(itemImage)
            } else {
                styleSetHorizontalInnerStackView2.addArrangedSubview(itemImage)
            }
            indexCount += 1
        }

        styleSetVerticalStackView.addArrangedSubview(styleSetHorizontalInnerStackView1)
        styleSetVerticalStackView.addArrangedSubview(styleSetHorizontalInnerStackView2)

        stackViewContainer.addSubview(styleSetVerticalStackView)

        contentView.addSubview(contentContainer)
        contentContainer.addSubview(stackViewContainer)
        contentContainer.addSubview(borderLine)
        contentContainer.addSubview(descriptionLabel)
    }

    private func configureLayout() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackViewContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Constants.stackViewContainerMultipliedHeight)
        }
        styleSetVerticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(Constants.styleSetVerticalStackWidthInset)
            make.height.equalToSuperview().inset(Constants.styleSetVerticalStackHeightInset)
        }
        borderLine.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(Constants.borderLineHeight)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackViewContainer.snp.bottom)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Constants.descriptionLabelMultipliedHeight)
        }
    }

}
