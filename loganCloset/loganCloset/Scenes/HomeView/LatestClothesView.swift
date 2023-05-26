//
//  LatestClothesView.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/25.
//

import UIKit
import SnapKit

final class LatestClothesView: UIView {

    // MARK: - Constants

    // MARK: - Properties

    // MARK: - UI Components
    let contentContainer: UIView = {
        let view =  UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 40
        return view
    }()
    let imageContainer: UIView = {
        let view =  UIView()
        return view
    }()
    let itemImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let borderLine: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return view
    }()
    let descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "My StyleSet"
        label.font = UIFont.importedUIFont(name: .pretendardBold, fontSize: 16)
        label.textAlignment = .center
        return label
    }()

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func configureItemImage(with clothes: [Clothes]?) {
        guard let clothes else { return }
        
        if clothes.isEmpty {
            itemImage.image = UIImage(named: ImageConstants.noneImage)
            descriptLabel.text = "등록된 옷이 없습니다."
            return
        }

        let latestClothes = clothes.first
        itemImage.image = latestClothes?.itemImage ?? UIImage(named: ImageConstants.noneImage)
        descriptLabel.text = latestClothes?.brandName ?? "Latest item"

    }
    // MARK: - Private
    private func configureHierachy() {
        addSubview(contentContainer)

        imageContainer.addSubview(itemImage)

        contentContainer.addSubview(imageContainer)
        contentContainer.addSubview(borderLine)
        contentContainer.addSubview(descriptLabel)
    }

    private func configureLayout() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(208)
        }
        itemImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().inset(16)
        }
        borderLine.snp.makeConstraints { make in
            make.top.equalTo(descriptLabel).inset(2)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        descriptLabel.snp.makeConstraints { make in
            make.top.equalTo(imageContainer.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(56)
        }
    }

}
