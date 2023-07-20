//
//  ItemImageButton.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/28.
//

import UIKit

final class ItemImageButton: UIButton {

    // MARK: - Constants
    enum Constants {
        static let hangerImageName: String = "hanger_icon"
        static let hangerImageNilName: String = "tshirt"
        static let accessoryImageName: String = "accessory_Icon"
        static let accessoryImageNilName: String = "eyeglasses"

        static let ItemImageButtonBorderWidth: CGFloat = 3
        static let ItemImageButtonCornerRadius: CGFloat = 16
        static let ItemImageButtonShadowOffset: CGFloat = 1
        static let ItemImageButtonShadowOpacity: Float = 0.1
        static let ItemImageButtonShadowRadius: CGFloat = 40
    }

    // MARK: - Properties
    var category: ClothesCategory? = nil
    var clothes: Clothes?

    // MARK: - UI Components
    private var hangerImage = UIImage(named: "hanger_icon") ?? UIImage(systemName: "tshirt")
    private var accessoryImage = UIImage(named: "accessory_Icon") ?? UIImage(systemName: "eyeglasses")

    // MARK: - LifeCycle
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(buttonFor: ClothesCategory) {
        self.init(frame: .zero)
        self.category = buttonFor
        switch buttonFor {
        case .accessory:
            self.setImage(accessoryImage, for: .normal)
        default:
            self.setImage(hangerImage, for: .normal)
        }

    }

    // MARK: - Public
    func updateItemData(with clothes: Clothes?) {
        guard let clothes else { return }
        self.setImage(clothes.itemImage, for: .normal)
        self.clothes = clothes
    }

    // MARK: - Private
    private func setupAppearance() {
        self.backgroundColor = UIColor(white: 0.9, alpha: 1)
        layer.borderWidth = Constants.ItemImageButtonBorderWidth
        layer.borderColor = UIColor.separator.cgColor
        layer.cornerRadius = Constants.ItemImageButtonCornerRadius
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        let offset = Constants.ItemImageButtonShadowOffset
        layer.shadowOffset = CGSize(width: offset, height: offset)
        layer.shadowOpacity = Constants.ItemImageButtonShadowOpacity
        layer.shadowRadius = Constants.ItemImageButtonShadowRadius
        self.imageView?.contentMode = .scaleAspectFill
        self.contentMode = .scaleAspectFit
    }

}
