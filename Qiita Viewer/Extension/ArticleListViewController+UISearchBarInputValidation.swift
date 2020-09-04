//
//  ArticleListViewController+UISearchBarInputValidation.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/09/04.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import UIKit

extension ArticleListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let blockStrList = ["~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "+", "=", "{", "[", "}", "]", "|", "\\", ":", ";", "\"", "\'", "<", ">", ",", ".", "?", "/", "¥", "€", "£", " "]
        
        if blockStrList.contains(text) { return false }
        return true
    }
}
