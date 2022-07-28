//
//  CarDetailsVCTests.swift
//  AutoCheckAfricaTests
//
//

import XCTest
@testable import AutoCheckAfrica

class CarDetailsVCTests: XCTestCase {
    var sut: CarDetailsVC!
    
    override func setUp() {
        sut = CarDetailsVC()
        sut.loadViewIfNeeded()
    }
    
    func test_view_initialized_correclty() throws {
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertEqual(sut.view.backgroundColor, UIColor(named: "backgroundColor"))
    }
    
    func test_view_initialized_hides_tabbar() throws {
        sut.beginAppearanceTransition(false, animated: false)
        let tabIsHidden = sut.tabBarController?.tabBar.isHidden ?? false
        XCTAssertFalse(tabIsHidden)
    }
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
