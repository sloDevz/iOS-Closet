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
    enum Constants {
        static let titleLabelFontSize: CGFloat = 18
        static let titleLabelText: String = "MY CLOSET"

        static let latestStyleSetViewTopInset: CGFloat = 24
        static let viewSideInset: CGFloat = 20
        static let latestClothesViewTopInset: CGFloat = 16
        static let latestViewHeight: CGFloat = 264
    }

    // MARK: - Properties
    private var clothesManager: ClothesManager?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleLabelText
        label.font = UIFont.importedUIFont(
            name: .pretendardExtraBold,
            fontSize: Constants.titleLabelFontSize
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

        updateLatestViews()
        configureHierachy()
        setViewLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateLatestViews()
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

    private func updateLatestViews() {
        let latestStyle = clothesManager?.fetchStyleSets().last
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
            make.top.equalToSuperview().inset(Constants.latestStyleSetViewTopInset)
            make.leading.trailing.equalToSuperview().inset(Constants.viewSideInset)
            make.height.equalTo(Constants.latestViewHeight)
        }

        latestClothesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(latestStyleSetView.snp.bottom).offset(Constants.latestClothesViewTopInset)
            make.leading.trailing.equalToSuperview().inset(Constants.viewSideInset)
            make.height.equalTo(Constants.latestViewHeight)
        }
    }

}

