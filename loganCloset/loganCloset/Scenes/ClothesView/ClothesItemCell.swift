//
//  ClothesItemCell.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/23.
//

import UIKit
import SnapKit

final class ClothesItemCell: UICollectionViewCell {

    // MARK: - Constants
    static let reuseidentifier = String(describing: ClothesItemCell.self)

    enum Constant {
        static let contentContainerCornerRadius: CGFloat = 8
        static let shadowOffset: CGFloat = 1
        static let shadowOpacity: Float = 0.1
        static let shadowRadius: CGFloat = 40

        static let cameraImageName: String = "Camera"
        static let addIconLabelFontSize: CGFloat = 14
        static let addIconLabelTitle: String = "옷 추가"

        static let tagLabelFontSize: CGFloat = 11
        static let tagShadowOpacity: Float = 0.5
        static let tagShadowRadius: CGFloat = 2

        static let itemIamgeEdgeInset: CGFloat = 16
        static let tagLabelLeadingTrailingBottomInset: CGFloat = 15
    }

    // MARK: - Properties

    // MARK: - UI Components
    private let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constant.contentContainerCornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        let offset = Constant.shadowOffset
        view.layer.shadowOffset = CGSize(width: offset, height: offset)
        view.layer.shadowOpacity = Constant.shadowOpacity
        view.layer.shadowRadius = Constant.shadowRadius
        return view
    }()
    private let cameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constant.cameraImageName)
        return imageView
    }()
    private let addItemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.importedUIFont(
            name: .pretendardMedium,
            fontSize: Constant.addIconLabelFontSize)
        label.text = Constant.addIconLabelTitle
        label.textColor = UIColor(white: 0.7, alpha: 1)
        return label
    }()
    private let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.importedUIFont(
            name: .pretendardMedium,
            fontSize: Constant.tagLabelFontSize)
        label.textColor = UIColor(white: 0.98, alpha: 1)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width:Constant.shadowOffset, height: Constant.shadowOffset)
        label.layer.shadowOpacity = Constant.tagShadowOpacity
        label.layer.shadowRadius = Constant.tagShadowRadius
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
    func configureContent(with item: Clothes) {
        setAppearanceFor(contenteMode: false)
        guard item.clothesCategory != .none else { return }
        setAppearanceFor(contenteMode: true)
        itemImage.image = item.itemImage
        tagLabel.text = item.tags?.joined()
    }

    // MARK: - Private
    private func configureHierachy() {
        contentView.addSubview(contentContainer)
        contentContainer.addSubview(cameraImage)
        contentContainer.addSubview(addItemLabel)
        contentContainer.addSubview(itemImage)
        contentContainer.addSubview(tagLabel)
    }

    private func configureLayout() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cameraImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentContainer.snp.centerY).offset(-(contentContainer.frame.height/20))
        }
        addItemLabel.snp.makeConstraints { make in
            make.centerX.equalTo(cameraImage)
            make.top.equalTo(contentContainer.snp.centerY).offset(contentContainer.frame.height/20)
        }
        itemImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constant.itemIamgeEdgeInset)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(Constant.tagLabelLeadingTrailingBottomInset)
        }
    }

    private func setAppearanceFor(contenteMode: Bool) {
        cameraImage.isHidden = contenteMode
        addItemLabel.isHidden = contenteMode
        itemImage.isHidden = !contenteMode
        tagLabel.isHidden = !contenteMode
    }

}
