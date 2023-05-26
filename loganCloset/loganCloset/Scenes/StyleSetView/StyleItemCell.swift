//
//  StyleItemCell.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/26.
//

import UIKit
import SnapKit

final class StyleItemCell: UICollectionViewCell {
    // MARK: - Constants

    // MARK: - Properties
    static let reuseidentifier = String(describing: StyleItemCell.self)

    // MARK: - UI Components
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

    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        guard item.clothesCategory != .none else { return }
        itemImage.image = item.itemImage
    }

    // MARK: - Private
    private func configureHierachy() {
        contentView.addSubview(contentContainer)
        contentContainer.addSubview(itemImage)
    }

    private func configureLayout() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        itemImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
