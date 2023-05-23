//
//  HomeViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    //MARK: - properties
    private var clothesManager: ClothesManager?

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
        view.backgroundColor = .orange
    }

    //MARK: - Methodes

    private func configureDataSource() {

    }
    



}

