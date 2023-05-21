//
//  ViewController.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit
import SnapKit
import Pretendard

class ViewController: UIViewController {

    var testLabel: UILabel = {
        let label = UILabel()
        label.text = "HelloWorld"
        label.font = .importedUIFont(name: .pretendardRegular, fontSize: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.testLabel)
        testLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(100)
            testLabel.backgroundColor = .brown
        }
    }


}

