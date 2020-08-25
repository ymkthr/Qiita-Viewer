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

class ArticleListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ArticleListViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.searchWord)
            .disposed(by: self.disposeBag)
        
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
    }
}
