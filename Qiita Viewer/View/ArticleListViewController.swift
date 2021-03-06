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
import AlamofireImage

final class ArticleListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private let viewModel = ArticleListViewModel()
    private let disposeBag = DisposeBag()
    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.placeholder = "ユーザー名で検索"
        searchBar.text = userName
        searchBar.delegate = self

        // サーチバーに入力された文字をviewModelにバインディング
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchWord)
            .disposed(by: disposeBag)

        // 取得された記事をtableViewにバインディング
        viewModel.articleList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "CustomCell", cellType: CustomCell.self)) { row, article, cell in
                let iconImageUrl = URL(string: article.user.profile_image_url)
                
                cell.titleLabel.text = article.title
                cell.urlLabel.text = article.url
                cell.userNameLabel.text = "@" + article.user.id
                cell.likeCountLabel.text = "LGTM: " + article.lgtm
                cell.dateCreatedLabel.text = "投稿日: " + article.date
                cell.iconImageView.af.setImage(withURL: iconImageUrl!)
            }
            .disposed(by: disposeBag)

        // タップした記事をWebViewで開く
        tableView.rx.modelSelected(Article.self)
            .subscribe(onNext: { [unowned self] article in
                let url = URL(string: article.url)
                if let url = url {
                    let safariViewController = SFSafariViewController(url: url)
                    self.present(safariViewController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)

        // インジケーター
        viewModel.isLoading.subscribe(onNext: { loadingStatus in
            switch loadingStatus {
            case .success:
                HUD.hide()
            case .failure:
                HUD.flash(.error, delay: 2)
            case .loading:
                HUD.show(.progress)
            }
        })
            .disposed(by: disposeBag)
    }

    // WebViewからの遷移時にセルの選択を解除する
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
}
