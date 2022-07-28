//
//  ExtensionsTests.swift
//  AutoCheckAfricaTests
//
//

import XCTest
@testable import AutoCheckAfrica

class ExtensionsTests: XCTestCase {
    var textField: UITextField!
    
    override func setUp() {
        textField = UITextField()
    }
    
    func test_setIcon_configures_correclty() throws {
        let image = try XCTUnwrap(UIImage(named: "logo"))
        
        textField.setIcon(image)

        XCTAssertEqual(textField.leftViewMode, .always)
        XCTAssertEqual(textField.leftView?.frame, CGRect(x: 20, y: 0, width: 30, height: 30))
    }
    
    func test_setsup_placeholdertext_correctly() throws {
        let text = "Test text"
        textField.placeholderText(text: text)
        XCTAssertEqual(textField.leftViewMode, .always)
        XCTAssertEqual(textField.leftView?.frame.width, 10)
        let placeHolder = try XCTUnwrap(textField.attributedPlaceholder?.string)
        XCTAssertEqual(placeHolder, "Test text")
    }
    
    override func tearDown() {
        textField = nil
    }
}
