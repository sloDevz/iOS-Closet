//
//  PhotoButton.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/30.
//

import UIKit

final class PhotoButton: UIButton {

    // MARK: - Constants

    // MARK: - Properties

    // MARK: - UI Components
    private var cameraImage = UIImage(named: "Add_Clothes_image_icon") ?? UIImage(systemName: "camera")
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
        layer.borderWidth = 3
        layer.borderColor = UIColor.separator.cgColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 40
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
        .frame(width: 400, height: 400) // 원하는 수치만큼 뷰 크기 조절 가능
        .previewLayout(.sizeThatFits)
    }
}
#endif
