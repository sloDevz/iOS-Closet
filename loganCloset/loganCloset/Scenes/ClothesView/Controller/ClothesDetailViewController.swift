//
//  ClothesDetailViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 11/23/23.
//

import UIKit
import SnapKit

final class ClothesDetailViewController: UIViewController {
    // MARK: - Constants

    // MARK: - Properties
    private var selectedItem: Clothes?
    private var clothesManager: ClothesManager?
    // MARK: - UI Components
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var itemImage = UIImageView()

    // MARK: - LifeCycle
    init(selectedItem: Clothes, clothesManager: ClothesManager) {
        super.init(nibName: nil, bundle: nil)
        self.selectedItem = selectedItem
        self.clothesManager = clothesManager
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUIComponents()
        configureHierarchy()
        configureLayoutConstraint()
        contentView.backgroundColor = .blue
    }


    // MARK: - Public

    // MARK: - Private
    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(itemImage)
    }
    private func configureLayoutConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }
        itemImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(view.snp.width).inset(24)
        }
    }
    private func setUIComponents() {
        itemImage.image = selectedItem?.itemImage
    }

}
