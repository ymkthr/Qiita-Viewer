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
    var api_token: String { get }
    var auth_header: HTTPHeaders { get }
    
    func getRequest(_ userName: String) -> DataRequest
}

class QiitaApiClient: APIClient {
    
    let api_token = "e738e431f62c3545463e3326228dc0b5a48f4522"
    let auth_header: HTTPHeaders
    
    init() {
        auth_header = [
            "Authorization" : "Bearer " + api_token
        ]
    }
    
    func getRequest(_ userName: String) -> DataRequest {
        
        let url = "https://qiita.com/api/v2/users/\(userName)/items?page=1&per_page=100"
        
        return AF.request(
            url,
            method: .get,
            headers: auth_header
        )
    }
}
