//
//  AlertManager.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/31.
//

import UIKit

final class AlertManager {
    static func popAlertWithConfirmAndCancel(viewController: UIViewController, title: String, message: String, placeholder: String? = nil, doneTitle: String, canelTitle: String, complition: @escaping (UIAlertAction) -> ()) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        if let placeholder {
            alertController.addTextField { texField in
                texField.placeholder = placeholder
            }
        }

        let doneAction = UIAlertAction(title: doneTitle, style: .default,handler: complition)
        let cancelAction = UIAlertAction(title: canelTitle, style: .cancel)

        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true)
    }

    static func presentMessageAlert(viewController: UIViewController, title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "확인", style: .default,handler: handler)

        alertController.addAction(action)

        viewController.present(alertController, animated: true, completion: nil)
    }
}
