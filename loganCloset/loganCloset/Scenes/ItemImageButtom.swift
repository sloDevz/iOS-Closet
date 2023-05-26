//
//  ItemImageButtom.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/26.
//

import UIKit

final class ItemImageButtom: UIButton {
    // MARK: - Constants

    // MARK: - Properties

    // MARK: - UI Components

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        let image = UIImage(named: "hanger_icon") ?? UIImage(systemName: "plus")
        self.setImage(image, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func setButtonEnable(_ value:Bool) {
        self.isEnabled = value
    }
    // MARK: - Private

}
