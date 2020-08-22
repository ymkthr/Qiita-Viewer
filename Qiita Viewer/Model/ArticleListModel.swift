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
                if let error = response.error {
                    observer.onError(error)
                }
                
                let decoder: JSONDecoder = JSONDecoder()
                var articles: [Article] = []
                do {
                    articles = try decoder.decode([Article].self, from: response.data!)
                    print(articles)
                } catch {
                    print(error.localizedDescription)
                }
                
                observer.onNext(articles)
                observer.onCompleted()
            }
            return Disposables.create { request.cancel() }
        }
    }
}
