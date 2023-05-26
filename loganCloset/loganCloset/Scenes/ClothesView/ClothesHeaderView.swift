//
//  ClothesHeaderView.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/24.
//

import UIKit
import SnapKit

final class ClothesHeaderView: UICollectionReusableView {

    //MARK: - Properties
    static let reuseableIdentifier = String(describing: ClothesHeaderView.self)

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.importedUIFont(name: .pretendardBold, fontSize: 18)

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

    //MARK: - Methodes
    private func configureTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(25)
        }
    }

}
