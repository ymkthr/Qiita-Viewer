//
//  ArticleListViewModel.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/22.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import RxSwift
import RxCocoa

final class ArticleListViewModel {
    let searchWord = PublishRelay<String>()
    let articleList = PublishRelay<[Article]>()
    let isLoading = PublishSubject<LoadingStatus>()
    private let disposeBag = DisposeBag()
    private let model = ArticleListModel()

    init() {
        searchWord.asObservable()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] str -> Single<[Article]> in
                self.isLoading.onNext(.loading)
                return self.model.fetchArticles(str)
                /* searchWordが空文字 -> 新着記事を取得
                   searchWordに文字有 -> ユーザーの記事を取得 */
            }
            .do(onNext: { _ in
                self.isLoading.onNext(.success)
            }, onError: { _ in
                self.isLoading.onNext(.failure)
            })
            .retry()
            .bind(to: articleList)
            .disposed(by: disposeBag)
    }
}
