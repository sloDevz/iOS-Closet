//
//  ItemImageButton.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/28.
//

import UIKit

final class ItemImageButton: UIButton {

    // MARK: - Constants
    enum buttonType {
        case clothes
        case accessory
    }
    // MARK: - Properties

    // MARK: - UI Components
    private var hangerImage = UIImage(named: "hanger_icon") ?? UIImage(systemName: "tshirt")
    private var accessoryImage = UIImage(named: "accessory_Icon") ?? UIImage(systemName: "eyeglasses")

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(buttonFor: buttonType ) {
        self.init(frame: .zero)

        switch buttonFor {
        case .clothes:
            self.setImage(hangerImage, for: .normal)
        case .accessory:
            self.setImage(accessoryImage, for: .normal)
        }

    }

    // MARK: - Public
    func setItemImage(with image: UIImage?) {
        guard let image else { return }
        self.setItemImage(with: image)
    }
    // MARK: - Private
    private func setupAppearance() {
        self.backgroundColor = UIColor(white: 0.9, alpha: 1)
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 40
        self.contentMode = .scaleAspectFit
    }

}
