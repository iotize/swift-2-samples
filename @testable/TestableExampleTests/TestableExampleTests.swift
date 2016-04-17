//
//  TestableExampleTests.swift
//  TestableExampleTests
//
//  Created by Ryan Davies on 20/03/2016.
//  Copyright © 2016 Ryan Davies. All rights reserved.
//

import XCTest
@testable import TestableExample

class TestableExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // KEY PART OF @testable IS THIS:
        // The module has been imported WITHOUT needing to be included in the unit test target!
        
        let model = SomeModel()
        XCTAssertEqual(model.calculateSomething(), 100)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
