//
//  ArticleListModel.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/22.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import Foundation
import RxSwift

final class ArticleListModel {

    private let client = QiitaApiClient()

    func fetchArticles(_ str: String) -> Single<[Article]> {
        return Single<[Article]>.create { single -> Disposable in
            let request = self.client.requestHandler(str).responseJSON { response in
                switch response.result {
                case .success:
                    let decoder: JSONDecoder = JSONDecoder()
                    var articles: [Article] = []
                    do {
                        articles = try decoder.decode([Article].self, from: response.data!)
                    } catch {
                        print(error.localizedDescription)
                        single(.error(error))
                    }
                    single(.success(articles))
                case .failure(let error):
                    print(error.localizedDescription)
                    single(.error(error))
                }
            }
            return Disposables.create { request.cancel() }
        }
    }
}
