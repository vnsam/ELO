//
//  ELOTests.swift
//  ELOTests
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import XCTest
@testable import ELO

class ELOTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testJSONObjectsDecode() {
        guard let jsonPath = Bundle.main.url(forResource: "gotjson", withExtension: "json"),
            let data = try? Data.init(contentsOf: jsonPath) else {
            XCTAssert(false, "JSON file not present in the path specified || DATA is nil")
                return
        }
        let decoder = JSONDecoder.init()
        let battles = try? decoder.decode([Battle].self, from: data)
        XCTAssert(nil != battles)
    }
    func testDummyFunction() {
        guard let jsonPath = Bundle.main.url(forResource: "gotjson", withExtension: "json"),
            let data = try? Data.init(contentsOf: jsonPath) else {
                XCTAssert(false, "JSON file not present in the path specified || DATA is nil")
                return
        }
        let decoder = JSONDecoder.init()
        let battles = try? decoder.decode([Battle].self, from: data)
        mapKingToBattles(battles!)
        XCTAssert(nil != battles)
    }
}
