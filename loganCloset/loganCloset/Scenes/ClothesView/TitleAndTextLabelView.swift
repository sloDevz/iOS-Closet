//
//  TitleAndTextLabelView.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 11/29/23.
//

import UIKit
import SnapKit

final class TitleAndTextLabelView: UIView {
    // MARK: - Constants

    // MARK: - Properties

    // MARK: - UI Components
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .importedUIFont(name: .pretendardExtraBold, fontSize: 18)
        label.textAlignment = .center
        return label
    }()
    private var textLabel: UILabel = {
        let label = UILabel()
        label.font = .importedUIFont(name: .pretendardMedium, fontSize: 18)
        label.textAlignment = .left
        return label
    }()

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, text: String? = nil) {
        self.init()
        self.titleLabel.text = title
        self.textLabel.text = text ?? "|    -"

        setUIComponentsLayout()
    }

    // MARK: - Public
    func changeText(to text: String) {
        textLabel.text = "|    " + text
    }
    func changeTitle(to title: String) {
        titleLabel.text = title
    }

    // MARK: - Private
    private func setUIComponentsLayout() {
        addSubview(titleLabel)
        addSubview(textLabel)

        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.top.bottom.equalTo(titleLabel)
        }
        self.snp.makeConstraints { make in
            make.height.equalTo(40)
        }

    }

}
