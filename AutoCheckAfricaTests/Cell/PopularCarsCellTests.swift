//
//  PopularCarsCellTests.swift
//  AutoCheckAfricaTests
//
//

import XCTest
@testable import AutoCheckAfrica

class PopularCarsCellTests: XCTestCase {
    var sut: PopularCarsCell!
    
    override func setUp() {
        sut = PopularCarsCell()
    }
    
    func test_subviews_setup_correctly() throws {
        XCTAssertNotNil(sut.imageView)
        XCTAssertNotNil(sut.lblTitle)
        XCTAssertEqual(sut.lblTitle.textColor, .black)
        XCTAssertEqual(sut.lblTitle.numberOfLines, 1)
        XCTAssertEqual(sut.lblTitle.textAlignment, .center)
        XCTAssertEqual(sut.lblTitle.backgroundColor, .clear)
    }
    
    func test_setUp_data_configures_correctly() throws {
        let makeList = createMakeList()
        sut.setupData(makeList)
        XCTAssertEqual(sut.lblTitle.text, "Name")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func createMakeList(_ isSVG: Bool = false) -> MakeList {
        let url = isSVG ? "www.google.com/image.svg" : "www.google.com/image"
        return MakeList(id: 1, name: "Name", imageURL: url)
    }
}
