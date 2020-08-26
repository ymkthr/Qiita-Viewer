//
//  ArticleListViewController.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/23.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices
import PKHUD

class ArticleListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ArticleListViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // サーチバーに入力された文字をviewModelにバインディング
        self.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.searchWord)
            .disposed(by: self.disposeBag)
        
        // 取得された記事をtableViewにバインディング
        self.viewModel.articleList.asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "CustomCell", cellType: CustomCell.self)) { row, article, cell in
                cell.titleLabel?.text = article.title
                cell.urlLabel?.text = article.url
                cell.userNameLabel?.text = "@" + article.user.id
                cell.likeCountLabel?.text = "LGTM: " + article.lgtm
                cell.dateCreatedLabel?.text = "投稿日: " + article.date
                cell.iconImageView?.image = UIImage(url: article.user.profile_image_url)
            }
            .disposed(by: self.disposeBag)
        
        // タップした記事をWebViewで開く
        self.tableView.rx.modelSelected(Article.self)
            .subscribe(onNext: { article in
                let url = URL(string: article.url)
                if let url = url{
                    let safariViewController = SFSafariViewController(url: url)
                    self.present(safariViewController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
        // インジケーター
        self.viewModel.isLoading.subscribe(onNext: { bool in
            bool ? HUD.show(.progress) : HUD.hide()
            })
            .disposed(by: disposeBag)
    }
}
