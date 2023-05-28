//
//  PickingItemViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/28.
//

import UIKit
import SnapKit

final class PickingItemViewController: UIViewController {

    // MARK: - Constants

    // MARK: - Properties
    var category: ClothesCategory?
    // MARK: - UI Components

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(category: ClothesCategory? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public

    // MARK: - Private

}

#if DEBUG
import SwiftUI
struct PickingItemViewController_Previews: PreviewProvider {
    static var previews: some View { Container().edgesIgnoringSafeArea(.all) }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController { return PickingItemViewController(category: .bottom) }
        func updateUIViewController(_ uiViewController: UIViewController,context: Context) { }
    }
}
#endif
