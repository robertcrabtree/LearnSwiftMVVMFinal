//
//  UIViewController+Alert.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/5/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

extension UIViewController {
    func showOKAlert(title: String?, message: String?, completion: (() -> Void)?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            }
        )
        present(alert, animated: true, completion: nil)
    }
}
