//
//  FontsTests.swift
//  AutoCheckAfricaTests
//
//

import XCTest
@testable import AutoCheckAfrica

class FontsTests: XCTestCase {
 
    func test_thinfont_updates_correctly() {
        let font = thinFont(size: 10)
        XCTAssertEqual(font.fontName, ".SFUI-Thin")
    }
    
    func test_lightFont_updates_correctly() {
        let font = lightFont(size: 10)
        XCTAssertEqual(font.fontName, ".SFUI-Light")
    }
    
    func test_regularFont_updates_correctly() {
        let font = regularFont(size: 10)
        XCTAssertEqual(font.fontName, ".SFUI-Regular")
    }
    
    func test_mediumFont_updates_correctly() {
        let font = mediumFont(size: 10)
        XCTAssertEqual(font.fontName, ".SFUI-Medium")
    }
    
    func test_boldFont_updates_correctly() {
        let font = boldFont(size: 10)
        XCTAssertEqual(font.fontName, ".SFUI-Bold")
    }
    
    func test_blackFont_updates_correctly() {
        let font = blackFont(size: 10)
        XCTAssertEqual(font.fontName, ".SFUI-Black")
    }
}
