//
//  TabBarController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit
import SnapKit

class TabBarViewController: UITabBarController {

    private let clothesIcon = UIImage(named: "MyClothes_icon")?.withRenderingMode(.alwaysOriginal)
    private let clothesSelectedIcon = UIImage(named: "MyClothes_icon_selected")?.withRenderingMode(.alwaysOriginal)
    private let homeIcon = UIImage(named: "Home_icons_24px_GNB")?.withRenderingMode(.alwaysOriginal)
    private let homeSelectedIcon = UIImage(named: "Home_icons_Selected24px_GNB")?.withRenderingMode(.alwaysOriginal)
    private let styleIcon = UIImage(named: "Styleset_icon")?.withRenderingMode(.alwaysOriginal)
    private let styleSelectedIcon = UIImage(named: "Styleset_icon_selected")?.withRenderingMode(.alwaysOriginal)

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }

    private func configureTabBar() {
        self.view.backgroundColor = .systemBackground

        let myClothesViewController = MyClothesViewController()
        let homeViewController = HomeViewController()
        let myStyleSetViewController = MyStyleSetViewController()

        myClothesViewController.tabBarItem = UITabBarItem(
            title: "옷",
            image: clothesIcon,
            selectedImage: clothesSelectedIcon
        )
        homeViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: homeIcon,
            selectedImage: homeSelectedIcon
        )
        myStyleSetViewController.tabBarItem = UITabBarItem(
            title: "스타일",
            image: styleIcon,
            selectedImage: styleSelectedIcon
        )
        self.setViewControllers([myClothesViewController, homeViewController, myStyleSetViewController], animated: false)
    }

}
