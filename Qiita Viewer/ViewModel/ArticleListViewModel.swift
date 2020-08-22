//
//  ArticleListViewModel.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/22.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleListViewModel {
    var searchWord         = PublishRelay<String>()
    var articleList        = PublishRelay<[Article]>()
    private let disposeBag = DisposeBag()
    private let model      = ArticleListModel()
    
    init() {
        searchWord.asObservable()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] str in
                return self.model.fetchArticles(str)
                /* searchWordが空文字 -> 新着記事を取得
                   searchWordに文字有 -> ユーザーの記事を取得 */
            }
            .bind(to: self.articleList)
            .disposed(by: self.disposeBag)
    }
}
