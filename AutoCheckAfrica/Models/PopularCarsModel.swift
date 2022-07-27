//
//  PopularCarsModel.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 24/07/2022.
//

import Foundation

// MARK: - Welcome
struct PopularCarsModel: Codable {
    let makeList: [MakeList]
    let pagination: Pagination
}

// MARK: - MakeList
struct MakeList: Codable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, currentPage, pageSize: Int
}
