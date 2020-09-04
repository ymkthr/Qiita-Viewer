//
//  UIViewController+hideKeyboard.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/09/04.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
