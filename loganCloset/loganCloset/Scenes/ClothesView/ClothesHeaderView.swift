//
//  ClothesHeaderView.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/24.
//

import UIKit
import SnapKit

final class ClothesHeaderView: UICollectionReusableView {

    // MARK: - Constants
    enum Constants {
        static let titleLabelFontSize: CGFloat = 18
        static let titleLabelLeadingInset: CGFloat = 20
        static let titleLabelTopInset: CGFloat = 25
    }
    
    //MARK: - Properties
    static let reuseableIdentifier = String(describing: ClothesHeaderView.self)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.importedUIFont(
            name: .pretendardBold,
            fontSize: Constants.titleLabelFontSize
        )
        return label
    }()

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Pirvate
    private func configureTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.titleLabelLeadingInset)
            make.top.equalToSuperview().inset(Constants.titleLabelTopInset)
        }
    }

    // MARK: - Public
    func setHeaderTitle(_ title: String) {
        titleLabel.text = title
    }

}
