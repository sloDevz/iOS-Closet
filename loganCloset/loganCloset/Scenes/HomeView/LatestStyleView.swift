//
//  LatestStyleView.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/25.
//

import UIKit
import SnapKit

final class LatestStyleView: UIView {

    // MARK: - Constants

    // MARK: - Properties

    // MARK: - UI Components
    let contentContainer: UIView = {
        let view =  UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 40
        return view
    }()
    let stackViewContainer: UIView = {
        let view =  UIView()
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
    let itemImage5: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let itemImage6: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let borderLine: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return view
    }()
    let descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "My StyleSet"
        label.font = UIFont.importedUIFont(name: .pretendardBold, fontSize: 16)
        label.textAlignment = .center
        return label
    }()
    var styleSetHorizontalInnerStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    var styleSetHorizontalInnerStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    var styleSetVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
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
    func configureItemImage(with styleSet: StyleSet?) {
        let cellImages = [itemImage1, itemImage2, itemImage3, itemImage4, itemImage5, itemImage6]
        var styleSetImages = styleSet?.items.compactMap { $0.itemImage }
        styleSetImages?.reverse()

        cellImages.forEach { iageView in
            iageView.image = styleSetImages?.popLast() ?? UIImage(named: ImageConstants.noneImage)
        }
        descriptLabel.text = styleSet?.name ?? "등록된 코디가 없습니다."
    }
    // MARK: - Private
    private func configureHierachy() {
        styleSetHorizontalInnerStackView1.addArrangedSubview(itemImage1)
        styleSetHorizontalInnerStackView1.addArrangedSubview(itemImage2)
        styleSetHorizontalInnerStackView1.addArrangedSubview(itemImage3)
        styleSetHorizontalInnerStackView2.addArrangedSubview(itemImage4)
        styleSetHorizontalInnerStackView2.addArrangedSubview(itemImage5)
        styleSetHorizontalInnerStackView2.addArrangedSubview(itemImage6)

        styleSetVerticalStackView.addArrangedSubview(styleSetHorizontalInnerStackView1)
        styleSetVerticalStackView.addArrangedSubview(styleSetHorizontalInnerStackView2)

        stackViewContainer.addSubview(styleSetVerticalStackView)

        addSubview(contentContainer)

        contentContainer.addSubview(stackViewContainer)
        contentContainer.addSubview(borderLine)
        contentContainer.addSubview(descriptLabel)
    }

    private func configureLayout() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackViewContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(208)
        }
        styleSetVerticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        borderLine.snp.makeConstraints { make in
            make.bottom.equalTo(descriptLabel.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        descriptLabel.snp.makeConstraints { make in
            make.top.equalTo(stackViewContainer.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(56)
        }
    }

}
