//
//  CarsViewCellTests.swift
//  AutoCheckAfricaTests
//
//

import XCTest
@testable import AutoCheckAfrica

class CarsViewCellTests: XCTestCase {
    var sut: CarsViewCell!
    
    override func setUp() {
        sut = CarsViewCell()
    }
    
    func test_subviews_setup_correctly() throws {
        XCTAssertNotNil(sut.imageView)
        XCTAssertNotNil(sut.lblTitle)
        XCTAssertNotNil(sut.lblOldAmount)
        XCTAssertNotNil(sut.lblAmount)
        XCTAssertNotNil(sut.addIcon)
        XCTAssertEqual(sut.lblTitle.textColor, UIColor(named: "blackColor"))
        XCTAssertEqual(sut.lblOldAmount.textColor, UIColor(named: "grayColor"))
        XCTAssertEqual(sut.lblAmount.textColor, UIColor(named: "blackColor"))
        XCTAssertEqual(sut.lblTitle.numberOfLines, 1)
        XCTAssertEqual(sut.lblOldAmount.numberOfLines, 1)
        XCTAssertEqual(sut.lblTitle.backgroundColor, .clear)
        XCTAssertEqual(sut.imageView.layer.cornerRadius, 10)
        XCTAssertEqual(sut.backgroundColor, .white)
    }
    
    func test_setUp_data_configures_correctly() throws {
        let carsModel = makeCarModel()
        sut.setupData(carsModel)
        XCTAssertEqual(sut.lblTitle.text, "Toyota")
        XCTAssertEqual(sut.lblOldAmount.text, String(describing: "Kes \(formatAmount(amount: carsModel.marketplaceOldPrice))"))
        XCTAssertEqual(sut.lblAmount.text, String(describing: "Kes \(formatAmount(amount: carsModel.marketplacePrice))"))
    }
    
//    func test_setUp_data_configures_image_correctly() throws {
//        let carsModel = makeCarModel()
//        let exp = expectation(description: "setupdata")
//        exp.expectedFulfillmentCount = 3
//        exp.assertForOverFulfill = true
//        sut.setupData(carsModel)
//        exp.fulfill()
//        waitForExpectations(timeout: 5) { [weak self] _ in
//            XCTAssertEqual(self?.sut.imageView.sd_imageURL, URL(string: "https://via.placeholder.com/600x400")!)
//        }
//    }
    
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func makeCarModel() -> CarsModel {
        let stats = Stats(webViewCount: 1, webViewerCount: 1, interestCount: 1, testDriveCount: 1, appViewCount: 1, appViewerCount: 1, processedLoanCount: 1)
        
        return CarsModel(id: "1", title: "Toyota", imageURL: "https://via.placeholder.com/600x400", year: 2022, city: "Nairobi", state: "Kenya", gradeScore: 10.0, sellingCondition: "New", hasWarranty: false, marketplacePrice: 10000, marketplaceOldPrice: 18000, hasFinancing: false, mileage: 1000, mileageUnit: "Miles", installment: 1, depositReceived: true, loanValue: 10.0, websiteURL: "www.google.com", stats: stats, bodyTypeID: "id", sold: false, hasThreeDImage: false, transmission: nil, fuelType: "", marketplaceVisibleDate: "", licensePlate: nil)
    }
}
