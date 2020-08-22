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
            .bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) { row, article, cell in
                cell.textLabel?.text = article.title
                cell.detailTextLabel?.text = article.url
            }
            .disposed(by: self.disposeBag)
    }
}
