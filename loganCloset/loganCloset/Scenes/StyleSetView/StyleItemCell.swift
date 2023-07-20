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
    enum Constants {
        static let selectedSignImageName: String = "pawprint.fill"
        static let contentContainerCornerRadius: CGFloat = 16
        static let contentContainerShadowOffset: CGFloat = 1
        static let contentContainerShadowOpacity: Float = 0.1
        static let contentContainerShadowRadius: CGFloat = 40

        static let selectedSignEdgeInset: CGFloat = 20
    }

    // MARK: - Properties
    static let reuseidentifier = String(describing: StyleItemCell.self)
    var baseClotehs: Clothes?

    // MARK: - UI Components
    private let selectedSign: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.selectedSignImageName)
        imageView.tintColor = UIColor.separator
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()

    private let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.contentContainerCornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        let offset = Constants.contentContainerShadowOffset
        view.layer.shadowOffset = CGSize(width: offset, height: offset)
        view.layer.shadowOpacity = Constants.contentContainerShadowOpacity
        view.layer.shadowRadius = Constants.contentContainerShadowRadius
        return view
    }()

    private let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.contentContainerCornerRadius
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

    func toggleSelectiedSign() {
        selectedSign.isHidden.toggle()
    }


    // MARK: - Private
    private func configureHierachy() {
        contentView.addSubview(contentContainer)
        contentView.addSubview(selectedSign)
        contentContainer.addSubview(itemImage)
    }

    private func configureLayout() {
        selectedSign.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(Constants.selectedSignEdgeInset)
        }
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
