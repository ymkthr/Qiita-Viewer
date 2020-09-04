//
//  StartSearchViewController+TextFieldInputValidation.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/09/04.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import UIKit

extension StartSearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString text: String) -> Bool {
        let blockStrList = ["~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "+", "=", "{", "[", "}", "]", "|", "\\", ":", ";", "\"", "\'", "<", ">", ",", ".", "?", "/", "¥", "€", "£", " "]
        
        if blockStrList.contains(text) { return false }
        return true
    }
}
