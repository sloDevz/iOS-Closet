//
//  TabBarController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit
import SnapKit

final class TabBarViewController: UITabBarController {

    // MARK: - Constants
    enum Constants {
        static let myClothesIconImageName: String = "MyClothes_icon"
        static let clothesSelectedIconImageName: String = "MyClothes_icon_selected"
        static let homeIconImageName: String = "Home_icons"
        static let homeSelectedIconImageName: String = "Home_icons_Selected"
        static let styleIconImageName: String = "Styleset_icon"
        static let styleSelectedIconImageName: String = "Styleset_icon_selected_OpenDoor"

        static let clothesTabTitle = "옷"
        static let homeTabTitle = "홈"
        static let styleTabTitle = "스타일"

        static let startingTabIndex: Int = 1
    }
    // MARK: - Properties
    private let clothesManager = ClothesManager()

    private let clothesIcon = UIImage(
        named: Constants.myClothesIconImageName)?
        .withRenderingMode(.alwaysOriginal
        )
    private let clothesSelectedIcon = UIImage(
        named: Constants.clothesSelectedIconImageName)?
        .withRenderingMode(.alwaysOriginal
        )
    private let homeIcon = UIImage(
        named: Constants.homeIconImageName)?
        .withRenderingMode(.alwaysOriginal
        )
    private let homeSelectedIcon = UIImage(
        named: Constants.homeSelectedIconImageName)?
        .withRenderingMode(.alwaysOriginal
        )
    private let styleIcon = UIImage(
        named: Constants.styleIconImageName)?
        .withRenderingMode(.alwaysOriginal
        )
    private let styleSelectedIcon = UIImage(
        named: Constants.styleSelectedIconImageName)?
        .withRenderingMode(.alwaysOriginal
        )

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    //MARK: - Methodes
    private func configureTabBar() {
        self.tabBar.backgroundColor = .systemBackground

        let clothesViewController = UINavigationController(
            rootViewController: ClothesViewController(clothesManager: clothesManager)
        )
        let homeViewController = UINavigationController(
            rootViewController: HomeViewController(clothesManager: clothesManager)
        )
        let styleSetViewController = UINavigationController(
            rootViewController: StyleSetViewController(clothesManager: clothesManager)
        )

        styleSetViewController.isNavigationBarHidden = false

        clothesViewController.tabBarItem = UITabBarItem(
            title: Constants.clothesTabTitle,
            image: clothesIcon,
            selectedImage: clothesSelectedIcon
        )
        homeViewController.tabBarItem = UITabBarItem(
            title: Constants.homeTabTitle,
            image: homeIcon,
            selectedImage: homeSelectedIcon
        )
        styleSetViewController.tabBarItem = UITabBarItem(
            title: Constants.styleTabTitle,
            image: styleIcon,
            selectedImage: styleSelectedIcon
        )
        setViewControllers([clothesViewController, homeViewController, styleSetViewController], animated: false)
        self.selectedIndex = Constants.startingTabIndex
    }

}
