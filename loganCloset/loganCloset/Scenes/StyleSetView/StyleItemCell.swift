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
    var baseClotehs: Clothes?

    // MARK: - UI Components
    let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 40
        return view
    }()

    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
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
        baseClotehs = item
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

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct View_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = StyleItemCell()
            cell.configureContent(with: Clothes(itemImage: UIImage(named: "Hats")!, clothesCategory: .hat, season: .all))
            return cell
        }
        .frame(width: 180, height: 180) // 원하는 수치만큼 뷰 크기 조절 가능
        .previewLayout(.sizeThatFits)
    }
}
#endif
