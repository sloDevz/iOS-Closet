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
        self.contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(makeSquare: CGFloat, typeFor: buttonType) {
        let squareFrame = CGRect(x: .zero, y: .zero, width: makeSquare, height: makeSquare)
        self.init(frame: squareFrame)

        switch typeFor {
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

}
