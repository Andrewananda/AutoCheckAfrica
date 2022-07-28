//
//  TabViewControllerTests.swift
//  AutoCheckAfricaTests
//
//

import XCTest
@testable import AutoCheckAfrica

class TabViewControllerTests: XCTestCase {
    var sut: TabViewController!
    
    override func setUp() {
        sut = TabViewController()
        sut.loadViewIfNeeded()
    }
    
    func test_view_is_initialized_correctly() throws {
        XCTAssertNotNil(sut)
    }
    
    func test_tabBar_is_configured_correctly() throws {
        XCTAssertTrue((sut.viewControllers?.count ?? 0) > 0)
    }
    
    func test_tabBar_vc_is_to_HomeVC() throws {
        guard let firstNav = sut.viewControllers?.first, let title = firstNav.tabBarItem.title else {
            XCTFail("No viewController set")
            return
        }
        
        XCTAssertEqual(title, "Home")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
