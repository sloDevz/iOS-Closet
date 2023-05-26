//
//  EditStyleViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/26.
//

import UIKit
import SnapKit

final class EditStyleViewController: UIViewController {
    // MARK: - Constants
    private typealias DataSource = UICollectionViewDiffableDataSource<ClothesCategory, Clothes>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<ClothesCategory, Clothes>

    // MARK: - Properties
    var clothesManager: ClothesManager?

    // MARK: - UI Components
    

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Public

    // MARK: - Private

}

#if DEBUG
import SwiftUI
struct EditStyleViewController_Previews: PreviewProvider {
    static var previews: some View { Container().edgesIgnoringSafeArea(.all) }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController { return EditStyleViewController() }
        func updateUIViewController(_ uiViewController: UIViewController,context: Context) { }
    }
}
#endif
