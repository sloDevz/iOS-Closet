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

    let contentContainer = UIView()
    let itemImage = UIImageView()
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.importedUIFont(name: .pretendardThin, fontSize: 12.0)
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
        addSubview(contentContainer)
        contentContainer.addSubview(itemImage)
        contentContainer.addSubview(tagLabel)
    }

    private func configureLayout() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        itemImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func configureContent(with item: Clothes) {
        itemImage.image = item.itemImage
        tagLabel.text = item.tags?.joined()
    }

}
