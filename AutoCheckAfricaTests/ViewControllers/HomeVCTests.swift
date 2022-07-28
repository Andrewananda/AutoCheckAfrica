//
//  HomeVCTests.swift
//  AutoCheckAfricaTests
//
//

import XCTest
@testable import AutoCheckAfrica

class HomeVCTests: XCTestCase {
    var sut: HomeVC!
    
    override func setUp() {
        sut = HomeVC()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
