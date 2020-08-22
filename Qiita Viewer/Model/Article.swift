//
//  Article.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/22.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String
    let created_at: String
    let likes_count: Int
    let url: String
    let user: User
}
