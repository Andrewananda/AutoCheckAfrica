//
//  ViewControllerUtilsTests.swift
//  AutoCheckAfricaTests
//
//

import XCTest
@testable import AutoCheckAfrica

class ViewControllerUtilsTests: XCTestCase {
    var sut: ViewControllerUtils!
    
    override func setUp() {
        sut = ViewControllerUtils()
    }
    
    func test_view_initializes_correctly() throws {
        XCTAssertNotNil(sut.container)
        XCTAssertNotNil(sut.loadingView)
        XCTAssertNotNil(sut.activityIndicator)
    }
    
    func test_showActivityIndicator_starts_indicator() throws {
        sut.showActivityIndicator(UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        XCTAssertEqual(sut.container.backgroundColor, sut.UIColorFromHex(0xffffff, alpha: 0.3))
        XCTAssertEqual(sut.loadingView.frame,  CGRect(x: 10, y: 10, width: 80, height: 80))
        XCTAssertEqual(sut.activityIndicator.color, .white)
        XCTAssertEqual(sut.loadingView.layer.cornerRadius, 10)
    }
    
    func test_hideActivityIndicator_removes_indicator() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        sut.showActivityIndicator(view)
        XCTAssertEqual(view.subviews.count, 1)
        
        //hide indicator
        sut.hideActivityIndicator(view)
        XCTAssertEqual(view.subviews.count, 0)
    }
    
    func test_formatAmount_formats_text_correctly() throws {
        let formattedAmount = formatAmount(amount: 1000)
        XCTAssertTrue(formattedAmount == "1,000")
    }
    
    override func tearDown() {
        sut = nil
    }
}
