//
//  extensionArticle.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/25.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

extension Article {
    var date: String  {
           get {
               let date = self.created_at.prefix(10)
               return String(date)
           }
       }
    
    var lgtm: String {
        get {
            let str = likes_count.description
            return str
        }
    }
    
}
