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
    enum Constants {
        static let contentContainerRadius: CGFloat = 8
        static let contentContainerShadowOffset: CGFloat = 1
        static let contentContainerShadowOpacity: Float = 0.1
        static let contentContainerShadowRadius: CGFloat = 40

        static let styleSetLabelSkeletonText: String = "My StyleSet"
    }
    // MARK: - Properties

    // MARK: - UI Components
    private let contentContainer: UIView = {
        let view =  UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.contentContainerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        let offset = Constants.contentContainerShadowOffset
        view.layer.shadowOffset = CGSize(width: offset, height: offset)
        view.layer.shadowOpacity = Constants.contentContainerShadowOpacity
        view.layer.shadowRadius = Constants.contentContainerShadowRadius
        return view
    }()
    private let stackViewContainer: UIView = {
        let view =  UIView()
        return view
    }()
    private let cellImages: [UIImageView] = {
        var imageViews = [UIImageView]()
        for _ in 0...5 {
            let itemImage1: UIImageView = {
                let image = UIImageView()
                image.contentMode = .scaleAspectFit
                return image
            }()
            imageViews.append(itemImage1)
        }

        return imageViews
    }()
    private let borderLine: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return view
    }()
    private let descriptLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.styleSetLabelSkeletonText
        label.textColor = .black
        label.font = UIFont.importedUIFont(name: .pretendardBold, fontSize: 16)
        label.textAlignment = .center
        return label
    }()
    private var styleSetHorizontalInnerStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var styleSetHorizontalInnerStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var styleSetVerticalStackView: UIStackView = {
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
        var styleSetImages = styleSet?.items.compactMap { $0.itemImage }
        styleSetImages?.reverse()

        cellImages.forEach { iageView in
            iageView.image = styleSetImages?.popLast() ?? UIImage(named: ImageConstants.noneImage)
        }
        descriptLabel.text = styleSet?.name ?? "등록된 코디가 없습니다."
    }
    // MARK: - Private
    private func configureHierachy() {
        var count = 0
        cellImages.forEach { imageView in
            if count < 3 {
                styleSetHorizontalInnerStackView1.addArrangedSubview(imageView)
            } else {
                styleSetHorizontalInnerStackView2.addArrangedSubview(imageView)
            }
            count += 1
        }

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
