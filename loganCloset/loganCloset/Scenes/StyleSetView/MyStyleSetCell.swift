//
//  MyStyleSetCell.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/25.
//

import UIKit
import SnapKit

final class MyStyleSetCell: UICollectionViewCell {

    // MARK: - Constants


    // MARK: - Properties
    static let reuseidentifier = String(describing: MyStyleSetCell.self)
    
    // MARK: - UI Components
    let contentContainer: UIView = {
        let view =  UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 40
        return view
    }()
    let stackViewContainer: UIView = {
        let view =  UIView()
        view.backgroundColor = .white
        return view
    }()
    let itemImage1: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let itemImage2: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let itemImage3: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let itemImage4: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "My StyleSet"
        label.font = UIFont.importedUIFont(name: .pretendardBold, fontSize: 14)
        label.textAlignment = .center
        return label
    }()
    let borderLine: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return view
    }()
    var styleSetHorizontalInnerStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    var styleSetHorizontalInnerStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    var styleSetVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
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
        let cellImages = [itemImage1, itemImage2, itemImage3, itemImage4]
        var styleSetImages = styleSet.items.compactMap { $0.itemImage }
        styleSetImages.reverse()

        cellImages.forEach { imageView in
            imageView.image = styleSetImages.popLast() ?? UIImage(named: ImageConstants.noneImage)
        }
        descriptLabel.text = styleSet.name
    }

    // MARK: - Private
    private func configureHierachy() {
        styleSetHorizontalInnerStackView1.addArrangedSubview(itemImage1)
        styleSetHorizontalInnerStackView1.addArrangedSubview(itemImage2)
        styleSetHorizontalInnerStackView2.addArrangedSubview(itemImage3)
        styleSetHorizontalInnerStackView2.addArrangedSubview(itemImage4)
        styleSetVerticalStackView.addArrangedSubview(styleSetHorizontalInnerStackView1)
        styleSetVerticalStackView.addArrangedSubview(styleSetHorizontalInnerStackView2)

        stackViewContainer.addSubview(styleSetVerticalStackView)

        contentView.addSubview(contentContainer)
        contentContainer.addSubview(stackViewContainer)
        contentContainer.addSubview(borderLine)
        contentContainer.addSubview(descriptLabel)
    }

    private func configureLayout() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackViewContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.78)
        }
        styleSetVerticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalToSuperview().inset(24)
        }
        borderLine.snp.makeConstraints { make in
            make.bottom.equalTo(descriptLabel.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        descriptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackViewContainer.snp.bottom)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.22)
        }
    }

}
