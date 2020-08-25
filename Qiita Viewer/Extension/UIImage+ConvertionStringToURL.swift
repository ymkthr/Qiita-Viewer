//
//  UIImage+ConvertionStringToURL.swift
//  Qiita Viewer
//
//  Created by Katsuhiro Yamauchi on 2020/08/25.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
