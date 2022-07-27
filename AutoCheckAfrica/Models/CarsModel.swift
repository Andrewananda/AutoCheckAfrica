//
//  CarsModel.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 27/07/2022.
//

import Foundation

// MARK: - CarsModel
struct CarsResponse: Codable {
    let result: [CarsModel]
    let pagination: Pagination
}


// MARK: - Result
struct CarsModel: Codable {
    let id, title: String
    let imageURL: String
    let year: Int
    let city: String
    let state: String
    let gradeScore: Double?
    let sellingCondition: String
    let hasWarranty: Bool
    let marketplacePrice, marketplaceOldPrice: Int
    let hasFinancing: Bool
    let mileage: Int
    let mileageUnit: String
    let installment: Int
    let depositReceived: Bool
    let loanValue: Double
    let websiteURL: String
    let stats: Stats
    let bodyTypeID: String
    let sold, hasThreeDImage: Bool
    let transmission: String?
    let fuelType: String
    let marketplaceVisibleDate: String
    let licensePlate: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "imageUrl"
        case year, city, state, gradeScore, sellingCondition, hasWarranty, marketplacePrice, marketplaceOldPrice, hasFinancing, mileage, mileageUnit, installment, depositReceived, loanValue
        case websiteURL = "websiteUrl"
        case stats
        case bodyTypeID = "bodyTypeId"
        case sold, hasThreeDImage, transmission, fuelType, marketplaceVisibleDate
        case licensePlate
    }

}

// MARK: - Stats
struct Stats: Codable {
    let webViewCount, webViewerCount, interestCount, testDriveCount: Int
    let appViewCount, appViewerCount, processedLoanCount: Int
}
