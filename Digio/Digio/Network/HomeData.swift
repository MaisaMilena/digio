// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeData = try? newJSONDecoder().decode(HomeData.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.homeDataTask(with: url) { homeData, response, error in
//     if let homeData = homeData {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - HomeData
public struct HomeData: Codable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}

// MARK: - Cash
public struct Cash: Codable {
    let title: String
    let bannerURL: String
    let cashDescription: String

    enum CodingKeys: String, CodingKey {
        case title, bannerURL
        case cashDescription = "description"
    }
}

// MARK: - Product
public struct Product: Codable {
    let name: String
    let imageURL: String
    let productDescription: String

    enum CodingKeys: String, CodingKey {
        case name, imageURL
        case productDescription = "description"
    }
}

// MARK: - Spotlight
public struct Spotlight: Codable {
    let name: String
    let bannerURL: String
    let spotlightDescription: String

    enum CodingKeys: String, CodingKey {
        case name, bannerURL
        case spotlightDescription = "description"
    }
}
