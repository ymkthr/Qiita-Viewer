//
//  StartSearchViewController.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/28.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import UIKit

final class StartSearchViewController: UIViewController {

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = "ユーザー名を入力"
        
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderColor = UIColor.gray.cgColor
        searchButton.layer.borderWidth = 1
    }
    

    @IBAction func didTapButton(_ sender: UIButton) {
        let storyboard = self.storyboard!
        let next = storyboard.instantiateViewController(withIdentifier: "articleList") as! ArticleListViewController
        next.modalPresentationStyle = .fullScreen
        next.userName = textField.text ?? ""

        self.present(next, animated: true, completion: nil)
    }
}
