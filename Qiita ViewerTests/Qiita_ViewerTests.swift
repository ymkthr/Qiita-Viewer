//
//  Qiita_ViewerTests.swift
//  Qiita ViewerTests
//
//  Created by Katsuhiro Yamauchi on 2020/08/22.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import RxTest
import RxBlocking
import Mockingjay
@testable import Qiita_Viewer

class Qiita_ViewerTests: QuickSpec {
    override func spec() {
        
        describe("QiitaApiClient") {
            context("URLのセット") {
                var client: QiitaApiClient!
                
                beforeEach {
                    client = QiitaApiClient()
                }
                
                it("ユーザー投稿取得URLをセット") {
                    let user = "qiita"
                    let expected = "https://qiita.com/api/v2/users/qiita/items?page=1&per_page=100"
                    client.requestHandler(user).response { _ in
                        return
                    }
                    expect(client.url).to(equal(expected))
                }
                it("新着記事取得URLをセット") {
                    let expected = "https://qiita.com/api/v2/items?page=1&per_page=100"
                    client.requestHandler("").response { _ in
                        return
                    }
                    expect(client.url).to(equal(expected))
                }
            }
        }
        
        describe("ArticleListModel") {
            context("ユーザー検索") {
                var model: ArticleListModel!

                beforeEach {
                    model = ArticleListModel()

                    let mockJson = "[ { \"rendered_body\": \"<p>本文</p>\n\", \"body\": \"本文\n\", \"coediting\": false, \"comments_count\": 0, \"created_at\": \"2020-08-24T17:01:50+09:00\", \"group\": null, \"id\": \"d8c0082067cbf4ec955b\", \"likes_count\": 0, \"private\": false, \"reactions_count\": 0, \"tags\": [ { \"name\": \"Swift\", \"versions\": [] } ], \"title\": \"APIテスト\", \"updated_at\": \"2020-08-24T17:01:50+09:00\", \"url\": \"https://qiita.com/yamkthr/items/d8c0082067cbf4ec955b\", \"user\": { \"description\": null, \"facebook_id\": null, \"followees_count\": 0, \"followers_count\": 0, \"github_login_name\": \"yamkthr\", \"id\": \"yamkthr\", \"items_count\": 1, \"linkedin_id\": null, \"location\": null, \"name\": \"\", \"organization\": null, \"permanent_id\": 151261, \"profile_image_url\": \"https://avatars.githubusercontent.com/u/17120602?v=3\", \"team_only\": false, \"twitter_screen_name\": null, \"website_url\": null }, \"page_views_count\": null } ]"
                    
                    self.stub(uri("https://qiita.com/api/v2/users/yamkthr/items?page=1&per_page=100"), jsonData(mockJson.data(using: .utf8)!))
                }
                
                it("該当あり") {
                    let expected = Article(
                        title: "APIテスト",
                        created_at: "2020-08-24T17:01:50+09:00",
                        likes_count: 0, url: "https://qiita.com/yamkthr/items/d8c0082067cbf4ec955b",
                        user: User(
                            id: "yamkthr",
                            profile_image_url: "https://avatars.githubusercontent.com/u/17120602?v=3"
                        )
                    )
//                    expect(try! model.fetchArticles("yamkthr").toBlocking().single()).to(equal(expected))
                }
                it("該当なし") {

                }
            }
        }
    }
}
