//
//  QiitaApiClient.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/22.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClient {
    var apiToken: String { get }
    var authHeader: HTTPHeaders { get }
    var url: String? { get }
    
    
    func getRequest() -> DataRequest
}

class QiitaApiClient: APIClient {
    
    let apiToken = "e738e431f62c3545463e3326228dc0b5a48f4522"
    let authHeader: HTTPHeaders
    var url: String?
    
    init() {
        authHeader = [
            "Authorization" : "Bearer " + apiToken
        ]
    }
    
    func getRequest() -> DataRequest {
        return AF.request(
            url!,
            method: .get,
            headers: authHeader
        )
    }
    
    func requestHandler(_ str: String) -> DataRequest {
        if str.isEmpty {
            setUrlLatestItem()
            return getRequest()
        } else {
            setUrlUserItem(str)
            return getRequest()
        }
    }
    
    func setUrlLatestItem() {
        url = "https://qiita.com/api/v2/items?page=1&per_page=100"
    }
    
    func setUrlUserItem(_ userName: String) {
        url = "https://qiita.com/api/v2/users/\(userName)/items?page=1&per_page=100"
    }
}
