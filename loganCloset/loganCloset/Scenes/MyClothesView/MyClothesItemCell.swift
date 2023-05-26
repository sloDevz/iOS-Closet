//
//  MyClothesItemCell.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/23.
//

import UIKit
import SnapKit

final class MyClothesItemCell: UICollectionViewCell {

    static let reuseidentifier = String(describing: MyClothesItemCell.self)

    let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 40
        return view
    }()
    let cameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Camera")
        return imageView
    }()
    let addItemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.importedUIFont(name: .pretendardMedium, fontSize: 14.0)
        label.text = "옷 추가"
        label.textColor = UIColor(white: 0.7, alpha: 1)
        return label
    }()
    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.importedUIFont(name: .pretendardMedium, fontSize: 12.0)
        label.textColor = UIColor(white: 0.98, alpha: 1)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            make.edges.equalToSuperview().inset(16)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(15)
        }
    }

    private func setAppearanceFor(contenteMode: Bool) {
        print(contenteMode)
        cameraImage.isHidden = contenteMode
        addItemLabel.isHidden = contenteMode
        itemImage.isHidden = !contenteMode
        tagLabel.isHidden = !contenteMode
    }

    func configureContent(with item: Clothes) {
        setAppearanceFor(contenteMode: false)
        guard item.clothesCategory != .none else { return }
        setAppearanceFor(contenteMode: true)
        itemImage.image = item.itemImage
        tagLabel.text = "#Tag"//item.tags?.joined()
    }

}
