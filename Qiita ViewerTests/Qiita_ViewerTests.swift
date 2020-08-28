//
//  Qiita_ViewerTests.swift
//  Qiita ViewerTests
//
//  Created by Katsuhiro Yamauchi on 2020/08/22.
//  Copyright © 2020 Katsuhiro Yamauchi. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking
@testable import Qiita_Viewer

class Qiita_ViewerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testQiitaApiClient_requestHandler() throws {
        
        let client = QiitaApiClient()
        
        client.requestHandler("qiita").response { _ in
            return
        }
        
        let exect = "https://qiita.com/api/v2/users/qiita/items?page=1&per_page=100"
        XCTAssertEqual (client.url, exect)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
