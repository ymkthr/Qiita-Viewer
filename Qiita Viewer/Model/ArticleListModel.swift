//
//  ArticleListModel.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/22.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import Foundation
import RxSwift

class ArticleListModel {
    
    let client = QiitaApiClient()
    
    func fetchArticles(_ str: String) -> Observable<[Article]> {
        return Observable<[Article]>.create { observer -> Disposable in
            let request = self.client.requestHandler(str).responseJSON { response in
                switch response.result {
                    case .success:
                        let decoder: JSONDecoder = JSONDecoder()
                        var articles: [Article] = []
                        do {
                            articles = try decoder.decode([Article].self, from: response.data!)
                        } catch {
                            print(error.localizedDescription)
                        }
                        observer.onNext(articles)
                        observer.onCompleted()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
            return Disposables.create { request.cancel() }
        }
    }
}
