//
//  EmptyStyleSetView.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/26.
//

import UIKit
import SnapKit

final class EmptyStyleSetView: UIView {
    // MARK: - Constants

    // MARK: - Properties

    // MARK: - UI Components
    let emptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "등록된 세트가 없습니다"
        label.font = UIFont.importedUIFont(name: .pretendardBold, fontSize: 20)
        label.textColor = UIColor(white: 0.7, alpha: 1)
        label.textAlignment = .center
        return label
    }()

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    // MARK: - Private
    private func configureHierarchy() {
        addSubview(emptyTextLabel)
    }

    private func configureLayout() {
        emptyTextLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }


}
