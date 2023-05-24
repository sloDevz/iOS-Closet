//
//  MyStyleSetViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit
import SnapKit

final class MyStyleSetViewController: UIViewController {

    //MARK: - properties
    private var clothesManager: ClothesManager?
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MY STYLE"
        label.font = UIFont.importedUIFont(
            name: .pretendardExtraBold,
            fontSize: 18
        )
        label.sizeToFit()
        return label
    }()
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Filter"), for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()

    //MARK: - Life Cycle
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
    }

    //MARK: - Methodes
    private func setViewAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }

    private func setNavigationBarItems() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }

    @objc
    private func filterButtonTapped() {
        print(#function)
    }
}

