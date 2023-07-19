//
//  HomeViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: - Constants

    // MARK: - Properties
    private var clothesManager: ClothesManager?
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MY CLOSET"
        label.font = UIFont.importedUIFont(
            name: .pretendardExtraBold,
            fontSize: 18
        )
        label.sizeToFit()
        return label
    }()

    // MARK: - UI Components
    private let homeScrollView = UIScrollView()
    private let contentView = UIView()
    private let latestStyleSetView = LatestStyleView(frame: .zero)
    private let latestClothesView = LatestClothesView(frame: .zero)

    // MARK: - LifeCycle
    init(clothesManager: ClothesManager? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.clothesManager = clothesManager
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAppearance()
        setNavigationBarItems()

        configureView()
        configureHierachy()
        setViewLayout()
    }

    // MARK: - Public

    // MARK: - Private
    private func setViewAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance

        view.backgroundColor = .systemBackground
    }

    private func setNavigationBarItems() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func configureHierachy() {
        view.addSubview(homeScrollView)
        homeScrollView.addSubview(contentView)
        contentView.addSubview(latestStyleSetView)
        contentView.addSubview(latestClothesView)
    }

    private func configureView() {
        let latestStyle = clothesManager?.fetchStyleSets().first
        latestStyleSetView.configureItemImage(with: latestStyle)

        let myClothes = clothesManager?.fetchCloset()
        latestClothesView.configureItemImage(with: myClothes)
    }

    private func setViewLayout() {
        homeScrollView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(homeScrollView.contentLayoutGuide)
            make.width.equalTo(homeScrollView.frameLayoutGuide)
            make.height.equalTo(view.snp.height)

        }
        latestStyleSetView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(264)
        }

        latestClothesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(latestStyleSetView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(264)
        }
    }

}

