//
//  PhotoButton.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/30.
//

import UIKit

final class PhotoButton: UIButton {

    // MARK: - Constants
    enum Constants {
        static let cameraImageName: String = "Add_Clothes_image_icon"
        static let buttonBorderWidth: CGFloat = 4
        static let buttonCornerRadius: CGFloat = 16
        static let buttonShadowOffset: CGFloat = 1
        static let buttonShadowOpacity: Float = 0.1
        static let buttonShadowRadius: CGFloat = 40
    }
    // MARK: - Properties

    // MARK: - UI Components
    private let cameraImage = UIImage(named: Constants.cameraImageName) ?? UIImage(systemName: "camera")

    // MARK: - LifeCycle
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init() {
        self.init(frame: .zero)
        self.setImage(cameraImage, for: .normal)
    }

    // MARK: - Public
    func updateButtonImage(with image: UIImage?) {
        guard let image else { return }
        self.setImage(image, for: .normal)
    }

    // MARK: - Private
    private func setupAppearance() {
        self.backgroundColor = UIColor(white: 0.9, alpha: 1)
        layer.borderWidth = Constants.buttonBorderWidth
        layer.borderColor = UIColor.separator.cgColor
        layer.cornerRadius = Constants.buttonCornerRadius
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(
            width: Constants.buttonShadowOffset,
            height: Constants.buttonShadowOffset)
        layer.shadowOpacity = Constants.buttonShadowOpacity
        layer.shadowRadius = Constants.buttonShadowRadius
        self.imageView?.contentMode = .scaleAspectFill
    }

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct PhotoButton_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = PhotoButton()
            cell.updateButtonImage(with: UIImage(named: "Add_Clothes_image_icon"))
            return cell
        }
        .frame(width: 400, height: 400)
        .previewLayout(.sizeThatFits)
    }
}
#endif
