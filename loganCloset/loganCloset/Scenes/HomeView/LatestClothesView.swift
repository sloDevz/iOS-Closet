//
//  LatestClothesView.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/25.
//

import UIKit
import SnapKit

final class LatestClothesView: UIView {

    // MARK: - Constants
    enum Constants {
        static let contentContainerRadius:CGFloat = 8
        static let contentContainerShadowOffset:CGFloat = 1
        static let contentContainerShadowOpacity:Float = 0.1
        static let contentContainerShadowRadius:CGFloat = 40

        static let describeFontSize: CGFloat = 16

        static let currentItemLabelSkeletonText:String = "Latest item"
        static let emptyViewGreetingText:String = "등록된 옷이 없습니다."

        static let imageContainerheight:CGFloat = 208
        static let itemImageHeightInset:CGFloat = 16
        static let describeLabelHeight:CGFloat = 56
        static let borderHeight:CGFloat = 1

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
    private let imageContainer: UIView = {
        let view =  UIView()
        return view
    }()
    private let itemImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let borderLine: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return view
    }()
    private let describeLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.currentItemLabelSkeletonText
        label.textColor = .black
        label.font = UIFont.importedUIFont(name: .pretendardBold, fontSize: Constants.describeFontSize)
        label.textAlignment = .center
        return label
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
    func configureItemImage(with clothes: Clothes?) {
        if let latestClothes = clothes {
            itemImage.image = latestClothes.itemImage 
            describeLabel.text = latestClothes.brandName ?? Constants.currentItemLabelSkeletonText
        }
        else  {
            itemImage.image = UIImage(named: ImageConstants.noneImage)
            describeLabel.text = Constants.emptyViewGreetingText
        }
    }
    
    // MARK: - Private
    private func configureHierachy() {
        addSubview(contentContainer)

        imageContainer.addSubview(itemImage)

        contentContainer.addSubview(imageContainer)
        contentContainer.addSubview(borderLine)
        contentContainer.addSubview(describeLabel)
    }

    private func configureLayout() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(Constants.imageContainerheight)
        }
        itemImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().inset(Constants.itemImageHeightInset)
        }
        borderLine.snp.makeConstraints { make in
            make.top.equalTo(describeLabel)
            make.width.equalToSuperview()
            make.height.equalTo(Constants.borderHeight)
        }
        describeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageContainer.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(Constants.describeLabelHeight)
        }
    }

}
